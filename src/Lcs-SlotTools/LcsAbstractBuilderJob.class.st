Class {
	#name : #LcsAbstractBuilderJob,
	#superclass : #LcsObject,
	#instVars : [
		'jobSteps'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #configuration }
LcsAbstractBuilderJob >> addJobStep: aBuilderJobStep [ 
	self jobSteps addJobStep: aBuilderJobStep
]

{ #category : #'gt view' }
LcsAbstractBuilderJob >> addModelClassesTo: classes [ 
	 self jobSteps addModelClassesTo: classes 
]

{ #category : #refactorings }
LcsAbstractBuilderJob >> addRefactoringsTo: aCollection [ 
	self jobSteps addRefactoringsTo: aCollection 
]

{ #category : #command }
LcsAbstractBuilderJob >> buildJobSteps [
	self subclassResponsibility
]

{ #category : #asking }
LcsAbstractBuilderJob >> builderJob [
	^self
]

{ #category : #refactorings }
LcsAbstractBuilderJob >> completedRefactorings [
	| allRefactorings |
	allRefactorings := OrderedCollection new.
	self addRefactoringsTo: allRefactorings.
	^ allRefactorings
]

{ #category : #command }
LcsAbstractBuilderJob >> execute [
	self jobSteps isEmpty ifTrue: [self buildJobSteps].
	self installCode.
	self verifyCodeInstallation.
	self updateSlotModel.
	self verifySlotModelUpdatesMadeByBuilder.
	self currentUnitOfWork applyChanges.
	self populateSlotModel.
	self verifyPopulateSlotModel.
	self currentUnitOfWork applyChanges
]

{ #category : #'gt view' }
LcsAbstractBuilderJob >> gtClassBuilderViewFor: aView [
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
LcsAbstractBuilderJob >> gtConstructionTreeFor: aView [
	<gtView>
	^ aView mondrian
		title: 'Steps Tree';
		priority: 2;
		painting: [ :aMondrian | LcsCodeBuilderTreeView newPaintTreeOn: aMondrian context: self ]
]

{ #category : #'gt view' }
LcsAbstractBuilderJob >> gtPaintUMLWith: aMondrian [ 
	aMondrian initialize: #LcsSlotModelDiagramExamples asClass new domainObjectSlotModel
]

{ #category : #'gt view' }
LcsAbstractBuilderJob >> gtUMLFor: aView [
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
		model root children withIndexDo: [ :child :n | child relocate: (positions at: n) ] ].		

	^ aView mondrian
		title: 'UML';
		priority: 20;
		initialize: model
		"painting: [ :aMondrian | 
			aMondrian initialize: model ]
			self gtPaintUMLWith: aMondrian" 
]

{ #category : #initialize }
LcsAbstractBuilderJob >> initialize [
	super initialize.
	self jobSteps: (LcsCodeBuilderJobSteps newOn: self)
]

{ #category : #command }
LcsAbstractBuilderJob >> installCode [
	self jobSteps installCode
]

{ #category : #'gt view' }
LcsAbstractBuilderJob >> jobStepDescription [
	| stream |
	stream := WriteStream on: String new.
	self printJobStreamDetailsOn: stream.
	^ stream contents
]

{ #category : #accessing }
LcsAbstractBuilderJob >> jobSteps [
	^ jobSteps
]

{ #category : #accessing }
LcsAbstractBuilderJob >> jobSteps: anObject [
	jobSteps := anObject
]

{ #category : #'gt view' }
LcsAbstractBuilderJob >> modelAssociations [
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
LcsAbstractBuilderJob >> modelClasses [
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

{ #category : #command }
LcsAbstractBuilderJob >> populateSlotModel [
	"subclasses can implement this method"
]

{ #category : #'gt view' }
LcsAbstractBuilderJob >> printJobStreamDetailsOn: aStream [
	aStream nextPutAll: self printString

]

{ #category : #command }
LcsAbstractBuilderJob >> uninstall [
	self jobSteps uninstall.
	self currentUnitOfWork applyChanges
]

{ #category : #command }
LcsAbstractBuilderJob >> updateSlotModel [
	self jobSteps updateSlotModel.
	self currentSystem currentUnitOfWork applyChanges	
]

{ #category : #command }
LcsAbstractBuilderJob >> verifyCodeInstallation [
	self jobSteps verifyCodeInstallation
]

{ #category : #command }
LcsAbstractBuilderJob >> verifyPopulateSlotModel [
	self jobSteps verifyPopulateSlotModel
]

{ #category : #command }
LcsAbstractBuilderJob >> verifySlotModelUpdatesMadeByBuilder [
	self jobSteps verifySlotModelUpdatesMadeByBuilder
]
