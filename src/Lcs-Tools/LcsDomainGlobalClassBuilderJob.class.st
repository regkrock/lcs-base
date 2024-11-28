Class {
	#name : #LcsDomainGlobalClassBuilderJob,
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
LcsDomainGlobalClassBuilderJob >> addJobStep: aBuilderJobStep [ 
	self jobSteps addJobStep: aBuilderJobStep
]

{ #category : #builders }
LcsDomainGlobalClassBuilderJob >> addMemberOfSlotBuilderForTargetClasses [
	self targetDomainClasses
		do: [ :eachClass | self addJobStep: (self domainClassMemberSlotBuilder: eachClass) ]
]

{ #category : #accessing }
LcsDomainGlobalClassBuilderJob >> addRefactoringsTo: refactorings [ 
	self jobSteps addRefactoringsTo: refactorings 
]

{ #category : #query }
LcsDomainGlobalClassBuilderJob >> builderJob [
	^self
]

{ #category : #accessing }
LcsDomainGlobalClassBuilderJob >> classPrefix [
	^ classPrefix
]

{ #category : #accessing }
LcsDomainGlobalClassBuilderJob >> classPrefix: aString [
	classPrefix := aString
]

{ #category : #accessing }
LcsDomainGlobalClassBuilderJob >> classRootName [
	^ classRootName
]

{ #category : #accessing }
LcsDomainGlobalClassBuilderJob >> classRootName: aString [
	classRootName := aString
]

{ #category : #accessing }
LcsDomainGlobalClassBuilderJob >> completedRefactorings [
	| allRefactorings |
	allRefactorings := OrderedCollection new.
	self addRefactoringsTo: allRefactorings.
	^ allRefactorings
]

{ #category : #configuration }
LcsDomainGlobalClassBuilderJob >> createForRootName: aRootName [
	self classRootName: aRootName.
	self domainInstanceSlotName: (self domainSlotNameFrom: self classRootName).
	self globalCollectionSlotName: self domainInstanceSlotName asEnglishPlural.
	self domainClassName: self classPrefix , aRootName.
	self globalCollectionClassName: self domainClassName asEnglishPlural
]

{ #category : #builders }
LcsDomainGlobalClassBuilderJob >> domainClassMemberSlotBuilder: eachClass [ 
	^ LcsMemberOfSlotBuilder new
		target: eachClass;
		collectionSlotName: self globalCollectionSlotName;
		slotName: self domainInstanceSlotName;
		targetModuleClass: self targetModule class;
		targetClassName: eachClass name;
		yourself
]

{ #category : #accessing }
LcsDomainGlobalClassBuilderJob >> domainClassName [
	^ domainClassName
]

{ #category : #accessing }
LcsDomainGlobalClassBuilderJob >> domainClassName: anObject [ 
	domainClassName := anObject
]

{ #category : #accessing }
LcsDomainGlobalClassBuilderJob >> domainInstanceSlotName [
	^ domainInstanceSlotName
]

{ #category : #accessing }
LcsDomainGlobalClassBuilderJob >> domainInstanceSlotName: aString [ 
	domainInstanceSlotName := aString
]

{ #category : #private }
LcsDomainGlobalClassBuilderJob >> domainSlotNameFrom: aRootName [
	^ (aRootName at: 1) asLowercase asString , (aRootName copyFrom: 2 to: aRootName size)
]

{ #category : #accessing }
LcsDomainGlobalClassBuilderJob >> globalCollectionClassName [
	^ globalCollectionClassName
]

{ #category : #accessing }
LcsDomainGlobalClassBuilderJob >> globalCollectionClassName: anObject [ 
	globalCollectionClassName := anObject
]

{ #category : #builders }
LcsDomainGlobalClassBuilderJob >> globalCollectionReferenceSlotBuilder [
	^ LcsGlobalCollectionReferenceSlotBuilder new
		targetClassName: self domainClassName;
		collectionSlotName: self globalCollectionSlotName;
		collectionSlotModuleName: self targetModuleName;
		yourself
]

{ #category : #accessing }
LcsDomainGlobalClassBuilderJob >> globalCollectionSlotName [
	^ globalCollectionSlotName
]

{ #category : #accessing }
LcsDomainGlobalClassBuilderJob >> globalCollectionSlotName: aString [
	globalCollectionSlotName := aString
]

{ #category : #'as yet unclassified' }
LcsDomainGlobalClassBuilderJob >> gtClassBuilderViewFor: aView [
	<gtView>
	^ aView columnedTree
		title: 'Steps List';
		priority: 10;
		expandUpTo: 3;
		items: [ self jobSteps ];
		children: [ :step | step jobSteps ];
		column: 'Number'
			text: [ :step | step stepNumber ] width: 55;
		column: 'Description'
			text: [ :step | step jobStepDescription ] width: 400;
		column: 'Step Class'
			text: [ :step | step class name ];
		column: ''
			stencil: [ :step | step viewCodeButton ];
		column: 'Status'
			stencil: [ :step | step state asString ]

]

{ #category : #accessing }
LcsDomainGlobalClassBuilderJob >> gtConstructionTreeFor: aView [
	<gtView>
	
	^ aView mondrian
		title: 'Steps Tree';
		priority: 2;
		painting: [ :aMondrian | self gtPaintTreeWith: aMondrian ]
]

{ #category : #'gt views' }
LcsDomainGlobalClassBuilderJob >> gtPaintTreeWith: aMondrian [ 

self
	withDeep: [ :each | each jobSteps collect: [:eachStep | eachStep]  ]
	do: [ :each | 
		aMondrian nodes
			stencil: [ :x | 
				BrVerticalPane new
					fitContent;
					addChild: (BrLabel new
							text: x class name;
							aptitude: (BrGlamorousLabelAptitude new
									foreground: Color gray;
									fontSize: 10));
					addChild: (BrLabel new
							text: x jobStepDescription;
							aptitude: BrGlamorousLabelAptitude new) ];
			with: {each} ]
	relationDo: [ :from :to | 
		aMondrian edges
			fromRightCenter;
			toLeftCenter;
			stencil: [ :x | 
				BlParabollaArcElement new
					zIndex: 0;
					curvatureFraction: 0.0;
					border: (BlBorder paint: (Color gray alpha: 0.2) width: 2);
					toHead: (BlArrowheadSimpleArrow new
							border: (BlBorder builder
									paint: (Color gray alpha: 0.2);
									width: 4;
									build)) ];
			connectAssociations: {from -> to} ].
aMondrian layout custom: (GtGraphHorizontalTreeLayout new
	levelDistance: 50;
	nodeDistance: 20).
aMondrian
]

{ #category : #'gt view' }
LcsDomainGlobalClassBuilderJob >> gtStepsMondrianTreeFor: aView [
	<gtView>
	^ aView empty
"	self jobSteps hasNoJobSteps ifTrue: [ ^ aView empty ].
	^ aView mondrian
		title: 'Steps';
		priority: 2;
		painting: [ :aMondrian | self paintTreeWith: aMondrian ]"
]

{ #category : #iniitialize }
LcsDomainGlobalClassBuilderJob >> initialize [
	super initialize.
	self
		jobSteps: (LcsCodeBuilderJobSteps newOn: self);
		classPrefix: 'Lcs'.
]

{ #category : #build }
LcsDomainGlobalClassBuilderJob >> installCode [
	self jobSteps installCode
]

{ #category : #configuration }
LcsDomainGlobalClassBuilderJob >> installMemberSlotInDomainClass: aClass [ 
	self targetDomainClasses add: aClass
]

{ #category : #configuration }
LcsDomainGlobalClassBuilderJob >> installNewClassesInPackageNamed: aString [ 
	self targetPackageName: aString
]

{ #category : #'gt views' }
LcsDomainGlobalClassBuilderJob >> jobStepDescription [
	| stream |
	stream := WriteStream on: String new.
	self printJobStreamDetailsOn: stream.
	^ stream contents
]

{ #category : #accessing }
LcsDomainGlobalClassBuilderJob >> jobSteps [
	^ jobSteps
]

{ #category : #accessing }
LcsDomainGlobalClassBuilderJob >> jobSteps: anObject [
	jobSteps := anObject
]

{ #category : #'gt view' }
LcsDomainGlobalClassBuilderJob >> paintTreeWith: view [
	view nodes
		shape: [ :each | 
			LcsCodeBuilderStepElement newFromStep: each ];
		with: (self withDeepCollect: #jobSteps).
	view edges
		shape: [ :each | BlLineElement new border: (BlBorder paint: (Color gray alpha: 0.5) width: 1 ) ];
		fromRightCenter;
		toLeftCenter;
		connectToAll: #steps.
	view layout custom: (GtGradWestHierarchicalLayout new alignment: GtGradHierarchicalLayoutRootAlignment new)
]

{ #category : #'gt views' }
LcsDomainGlobalClassBuilderJob >> printJobStreamDetailsOn: aStream [
	aStream nextPutAll: self printString

]

{ #category : #'gt view' }
LcsDomainGlobalClassBuilderJob >> stateColor [
	^Color green
]

{ #category : #'gt view' }
LcsDomainGlobalClassBuilderJob >> stepIcon [
	<return: #BlElement or: nil>
	^ nil
]

{ #category : #accessing }
LcsDomainGlobalClassBuilderJob >> targetDomainClasses [
	^ targetDomainClasses
]

{ #category : #accessing }
LcsDomainGlobalClassBuilderJob >> targetDomainClasses: aCollection [
	targetDomainClasses := aCollection
]

{ #category : #accessing }
LcsDomainGlobalClassBuilderJob >> targetModule [
	^ self currentSystem moduleNamed: self targetModuleName
]

{ #category : #accessing }
LcsDomainGlobalClassBuilderJob >> targetModuleClass [
	^ targetModuleClass
]

{ #category : #accessing }
LcsDomainGlobalClassBuilderJob >> targetModuleClass: aModuleClass [
	targetModuleClass := aModuleClass
]

{ #category : #accessing }
LcsDomainGlobalClassBuilderJob >> targetModuleName [
	^ targetModuleName ifNil: [ targetModuleName := self targetModuleClass moduleName ]
]

{ #category : #accessing }
LcsDomainGlobalClassBuilderJob >> targetModuleName: aString [
	targetModuleName := aString
]

{ #category : #accessing }
LcsDomainGlobalClassBuilderJob >> targetPackageName [
	^ targetPackageName
]

{ #category : #accessing }
LcsDomainGlobalClassBuilderJob >> targetPackageName: aString [ 
	targetPackageName := aString
]

{ #category : #building }
LcsDomainGlobalClassBuilderJob >> uninstall [
	self jobSteps uninstall.
	self currentUnitOfWork applyChanges
]

{ #category : #'slot model' }
LcsDomainGlobalClassBuilderJob >> verifyCodeInstallation [
	self jobSteps verifyCodeInstallation
]
