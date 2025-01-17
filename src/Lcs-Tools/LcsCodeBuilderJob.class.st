Class {
	#name : #LcsCodeBuilderJob,
	#superclass : #LcsObject,
	#instVars : [
		'classPrefix',
		'jobSteps',
		'targetPackageName',
		'domainInstanceSlotName',
		'classRootName',
		'globalCollectionSlotName',
		'domainClassName',
		'targetDomainClasses',
		'targetModuleName',
		'targetModuleClass'
	],
	#category : #'Lcs-Tools'
}

{ #category : #configuration }
LcsCodeBuilderJob >> addJobStep: aBuilderJobStep [ 
	self jobSteps addJobStep: aBuilderJobStep
]

{ #category : #builders }
LcsCodeBuilderJob >> addMemberOfSlotBuilderForTargetClasses [
	self targetDomainClasses
		do: [ :eachClass | self addJobStep: (self domainClassMemberSlotBuilder: eachClass) ]
]

{ #category : #'gt view' }
LcsCodeBuilderJob >> addModelClassesTo: classes [ 
	 self jobSteps addModelClassesTo: classes 
]

{ #category : #refactorings }
LcsCodeBuilderJob >> addRefactoringsTo: refactorings [ 
	self jobSteps addRefactoringsTo: refactorings 
]

{ #category : #query }
LcsCodeBuilderJob >> builderJob [
	^self
]

{ #category : #accessing }
LcsCodeBuilderJob >> classPrefix [
	^ classPrefix
]

{ #category : #accessing }
LcsCodeBuilderJob >> classPrefix: aString [
	classPrefix := aString
]

{ #category : #accessing }
LcsCodeBuilderJob >> classRootName [
	^ classRootName
]

{ #category : #accessing }
LcsCodeBuilderJob >> classRootName: aString [
	classRootName := aString
]

{ #category : #refactorings }
LcsCodeBuilderJob >> completedRefactorings [
	| allRefactorings |
	allRefactorings := OrderedCollection new.
	self addRefactoringsTo: allRefactorings.
	^ allRefactorings
]

{ #category : #configuration }
LcsCodeBuilderJob >> createForRootName: aRootName [
	self classRootName: aRootName.
	self domainInstanceSlotName: (self domainSlotNameFrom: self classRootName).
	self globalCollectionSlotName: self domainInstanceSlotName asEnglishPlural.
	self domainClassName: self classPrefix , aRootName.
	self globalCollectionClassName: self domainClassName asEnglishPlural
]

{ #category : #builders }
LcsCodeBuilderJob >> domainClassMemberSlotBuilder: eachClass [ 
	^ LcsMemberOfSlotBuilder new
		target: eachClass;
		targetClassName: eachClass name;
		slotName: self domainInstanceSlotName;
		collectionSlotName: self globalCollectionSlotName;
		targetModuleClass: self targetModule class;
		addSlotType: self domainClassName;
		yourself
]

{ #category : #accessing }
LcsCodeBuilderJob >> domainClassName [
	^ domainClassName
]

{ #category : #accessing }
LcsCodeBuilderJob >> domainClassName: anObject [ 
	domainClassName := anObject
]

{ #category : #accessing }
LcsCodeBuilderJob >> domainInstanceSlotName [
	^ domainInstanceSlotName
]

{ #category : #accessing }
LcsCodeBuilderJob >> domainInstanceSlotName: aString [ 
	domainInstanceSlotName := aString
]

{ #category : #private }
LcsCodeBuilderJob >> domainSlotNameFrom: aRootName [
	^ (aRootName at: 1) asLowercase asString , (aRootName copyFrom: 2 to: aRootName size)
]

{ #category : #accessing }
LcsCodeBuilderJob >> globalCollectionClassName [
	^ globalCollectionClassName
]

{ #category : #accessing }
LcsCodeBuilderJob >> globalCollectionClassName: anObject [ 
	globalCollectionClassName := anObject
]

{ #category : #builders }
LcsCodeBuilderJob >> globalCollectionReferenceSlotBuilder [
	^ LcsGlobalCollectionReferenceSlotBuilder new
		targetClassName: self domainClassName;
		collectionSlotName: self globalCollectionSlotName;
		collectionSlotModuleName: self targetModuleName;
		collectionClassName: self globalCollectionClassName;
		yourself
]

{ #category : #accessing }
LcsCodeBuilderJob >> globalCollectionSlotName [
	^ globalCollectionSlotName
]

{ #category : #accessing }
LcsCodeBuilderJob >> globalCollectionSlotName: aString [
	globalCollectionSlotName := aString
]

{ #category : #'gt view' }
LcsCodeBuilderJob >> gtClassBuilderViewFor: aView [
	<gtView>
	^ aView columnedTree
		title: 'Steps List';
		priority: 10;
		expandUpTo: 3;
		items: [ self jobSteps ];
		children: [ :step | step jobSteps ];
		"column: 'Number'
			text: [ :step | step stepNumber ] width: 55;"
		column: 'Step'
			text: [ :step | step jobStepDescription ] width: 400;
		column: 'Step Class'
			text: [ :step | step class name ];
		column: ''
			stencil: [ :step | step viewCodeButton ];
		column: 'Status'
			text: [ :step | step state asString asRopedText ]

]

{ #category : #'gt view' }
LcsCodeBuilderJob >> gtConstructionTreeFor: aView [
	<gtView>
	^ aView mondrian
		title: 'Steps Tree';
		priority: 2;
		painting: [ :aMondrian | LcsCodeBuilderTreeView newPaintTreeOn: aMondrian context: self ]
]

{ #category : #'gt view' }
LcsCodeBuilderJob >> gtPaintUMLWith: aMondrian [ 
	aMondrian initialize: #LcsSlotModelDiagramExamples asClass new domainObjectSlotModel
]

{ #category : #'gt view' }
LcsCodeBuilderJob >> gtUMLFor: aView [
	<gtView>
	| model classes associations positions |
	(classes := self modelClasses) ifEmpty: [ ^ aView empty ]. "examples domainObjectSlotModelClasses."
	associations := self modelAssociations "examples domainObjectSlotModelAssociationsWithLabels".

	positions := #(). "See: LcsSlotModelDiagramExamples>>#domainObjectSlotModelExplicitPositions".
	model := UmlClassDiagram new
				classHierarchyFor: classes
				withAssociationsAndLabels: associations.
	model layout custom: BlBasicLayout new.
	positions notEmpty ifTrue: [
		model root children withIndexDo: [ :child :n | child relocate: (self umlPositions at: n) ] ].		

	^ aView mondrian
		title: 'UML';
		priority: 20;
		initialize: model
		"painting: [ :aMondrian | 
			aMondrian initialize: model ]
			self gtPaintUMLWith: aMondrian" 
]

{ #category : #iniitialize }
LcsCodeBuilderJob >> initialize [
	super initialize.
	self
		jobSteps: (LcsCodeBuilderJobSteps newOn: self);
		classPrefix: 'Lcs'.
]

{ #category : #command }
LcsCodeBuilderJob >> installCode [
	self jobSteps installCode
]

{ #category : #configuration }
LcsCodeBuilderJob >> installMemberSlotInDomainClass: aClass [ 
	self targetDomainClasses add: aClass
]

{ #category : #configuration }
LcsCodeBuilderJob >> installNewClassesInPackageNamed: aString [ 
	self targetPackageName: aString
]

{ #category : #'gt view' }
LcsCodeBuilderJob >> jobStepDescription [
	| stream |
	stream := WriteStream on: String new.
	self printJobStreamDetailsOn: stream.
	^ stream contents
]

{ #category : #accessing }
LcsCodeBuilderJob >> jobSteps [
	^ jobSteps
]

{ #category : #accessing }
LcsCodeBuilderJob >> jobSteps: anObject [
	jobSteps := anObject
]

{ #category : #'gt view' }
LcsCodeBuilderJob >> modelAssociations [
	| associations |
	associations := OrderedCollection new.
	[ self jobSteps addModelAssociationsTo: associations ] 
		on: NotFound 
		do: [:signal | 
			associations removeAll.
			signal return: OrderedCollection new ].
	^ associations
]

{ #category : #'gt view' }
LcsCodeBuilderJob >> modelClasses [
	| classes |
	classes := OrderedCollection new.
	[ self jobSteps addModelClassesTo: classes ] 
		on: NotFound 
		do: [:signal | 
			classes removeAll.
			signal return: OrderedCollection new ].
	classes removeDuplicates.
	classes remove: Object ifAbsent: [ ].
	([ 'ProtoObject' asClass ] on: NotFound do: [ nil ])
		ifNotNil: [ :class | classes remove: class ifAbsent: [  ] ].
	^ classes
]

{ #category : #'gt view' }
LcsCodeBuilderJob >> printJobStreamDetailsOn: aStream [
	aStream nextPutAll: self printString

]

{ #category : #accessing }
LcsCodeBuilderJob >> targetDomainClasses [
	^ targetDomainClasses
]

{ #category : #accessing }
LcsCodeBuilderJob >> targetDomainClasses: aCollection [
	targetDomainClasses := aCollection
]

{ #category : #asking }
LcsCodeBuilderJob >> targetModule [
	^ self currentSystem moduleNamed: self targetModuleName
]

{ #category : #accessing }
LcsCodeBuilderJob >> targetModuleClass [
	^ targetModuleClass
]

{ #category : #accessing }
LcsCodeBuilderJob >> targetModuleClass: aModuleClass [
	targetModuleClass := aModuleClass
]

{ #category : #accessing }
LcsCodeBuilderJob >> targetModuleName [
	^ targetModuleName ifNil: [ targetModuleName := self targetModuleClass moduleName ]
]

{ #category : #accessing }
LcsCodeBuilderJob >> targetModuleName: aString [
	targetModuleName := aString
]

{ #category : #accessing }
LcsCodeBuilderJob >> targetPackageName [
	^ targetPackageName
]

{ #category : #accessing }
LcsCodeBuilderJob >> targetPackageName: aString [ 
	targetPackageName := aString
]

{ #category : #command }
LcsCodeBuilderJob >> uninstall [
	self jobSteps uninstall.
	self currentUnitOfWork applyChanges
]

{ #category : #command }
LcsCodeBuilderJob >> verifyCodeInstallation [
	self jobSteps verifyCodeInstallation
]
