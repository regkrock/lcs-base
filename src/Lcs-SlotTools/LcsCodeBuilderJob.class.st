Class {
	#name : #LcsCodeBuilderJob,
	#superclass : #LcsApplicationObject,
	#instVars : [
		'jobSteps',
		'buildUnknownClass'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #configuration }
LcsCodeBuilderJob >> addJobStep: aJobStep [ 
	^ self jobSteps addJobStep: aJobStep
]

{ #category : #'gt views' }
LcsCodeBuilderJob >> addModelClassesTo: classes [ 
	 self jobSteps addModelClassesTo: classes 
]

{ #category : #refactorings }
LcsCodeBuilderJob >> addRefactoringsTo: aCollection [ 
	self jobSteps addRefactoringsTo: aCollection 
]

{ #category : #command }
LcsCodeBuilderJob >> buildJobSteps [
	"subclasses can override this"
]

{ #category : #accessing }
LcsCodeBuilderJob >> buildUnknownClass [
	^ buildUnknownClass
]

{ #category : #accessing }
LcsCodeBuilderJob >> buildUnknownClass: aBoolean [ 
	buildUnknownClass := aBoolean
]

{ #category : #asking }
LcsCodeBuilderJob >> builderJob [
	^self
]

{ #category : #refactorings }
LcsCodeBuilderJob >> completedRefactorings [
	| allRefactorings |
	allRefactorings := OrderedCollection new.
	self addRefactoringsTo: allRefactorings.
	^ allRefactorings
]

{ #category : #command }
LcsCodeBuilderJob >> execute [
	self jobSteps isEmpty ifTrue: [self buildJobSteps].
	self installCode.
	self verifyCodeInstallation.
	self updateSlotModel.
	self verifySlotModelUpdatesMadeByBuilder.
	self currentSystem isNil ifTrue: [ ^ self ].
	self currentUnitOfWork applyChanges.
	self populateSlotModel.
	self verifyPopulateSlotModel.
	self currentUnitOfWork applyChanges
]

{ #category : #'gt views' }
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

{ #category : #'gt views' }
LcsCodeBuilderJob >> gtConstructionTreeFor: aView [
	<gtView>
	^ aView mondrian
		title: 'Steps Tree';
		priority: 2;
		painting: [ :aMondrian | LcsCodeBuilderTreeView newPaintTreeOn: aMondrian context: self ];
		actionUpdateButton
]

{ #category : #'gt views' }
LcsCodeBuilderJob >> gtExecutionViewFor: aView [
	<gtView>
	^ (LcsCodeBuilderJob>>#execute gtSourceFor: aView)
			title: 'Execution';
			priority: 15

]

{ #category : #'gt views' }
LcsCodeBuilderJob >> gtPaintUMLWith: aMondrian [ 
	aMondrian initialize: #LcsSlotModelDiagramExamples asClass new domainObjectSlotModel
]

{ #category : #'gt views' }
LcsCodeBuilderJob >> gtUMLFor: aView [
	<gtView>
	| classes |
	(classes := self modelClasses) ifEmpty: [ aView empty ].
	^ aView mondrian
		title: 'UML';
		priority: 20;
		initialize: (self umlModelFor: classes)
]

{ #category : #initialize }
LcsCodeBuilderJob >> initialize [
	super initialize.
	self jobSteps: (LcsCodeBuilderJobSteps newOn: self)
]

{ #category : #command }
LcsCodeBuilderJob >> installCode [
	self traceStep: 'installCode'.
	self jobSteps installCode
]

{ #category : #'gt views' }
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

{ #category : #'gt views' }
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

{ #category : #'gt views' }
LcsCodeBuilderJob >> modelClasses [
	| classes |
	classes := OrderedCollection new.
	self jobSteps addModelClassesTo: classes.
	classes removeDuplicates.
	classes remove: Object ifAbsent: [ ].
	([ 'ProtoObject' asClass ] on: NotFound do: [ nil ])
		ifNotNil: [ :class | classes remove: class ifAbsent: [  ] ].
	^ classes
]

{ #category : #command }
LcsCodeBuilderJob >> populateSlotModel [
	self traceStep: 'populateSlotModel'.
	self jobSteps populateSlotModel.
	self currentSystem currentUnitOfWork applyChanges
]

{ #category : #'gt views' }
LcsCodeBuilderJob >> printJobStreamDetailsOn: aStream [
	aStream nextPutAll: self printString

]

{ #category : #'as yet unclassified' }
LcsCodeBuilderJob >> stepNumber [
	^ ''
]

{ #category : #command }
LcsCodeBuilderJob >> traceStep: aMethodName [
	self traceCr: aMethodName , '-' , self printString
]

{ #category : #'gt views' }
LcsCodeBuilderJob >> umlModelFor: umlModelClasses [
"	| model associations positions |
	associations := self modelAssociations 'examples domainObjectSlotModelAssociationsWithLabels'.

	positions := #(). See: LcsSlotModelDiagramExamples>>#domainObjectSlotModelExplicitPositions.
	model := UmlClassDiagram new
				classHierarchyFor: classes
				withAssociationsAndLabels: associations.
	model layout custom: BlBasicLayout new.
	positions notEmpty ifTrue: [
		model root children withIndexDo: [ :child :n | child relocate: (positions at: n) ] ].	"

	^ LcsUml new newClassesUmlFor: umlModelClasses

]

{ #category : #command }
LcsCodeBuilderJob >> uninstall [
	self traceStep: 'uninstall'.
	self jobSteps uninstall.
	self currentUnitOfWork applyChanges
]

{ #category : #command }
LcsCodeBuilderJob >> updateSlotModel [
	self traceStep: 'updateSlotModel'.
	self currentSystem isNil ifTrue: [ ^ self ].
	self jobSteps updateSlotModel.
	self currentSystem currentUnitOfWork applyChanges	
]

{ #category : #command }
LcsCodeBuilderJob >> verifyCodeInstallation [
	self traceStep: 'verifyCodeInstallation'.
	self jobSteps verifyCodeInstallation
]

{ #category : #command }
LcsCodeBuilderJob >> verifyPopulateSlotModel [
	self jobSteps verifyPopulateSlotModel
]

{ #category : #command }
LcsCodeBuilderJob >> verifySlotModelUpdatesMadeByBuilder [
	self traceStep: 'verifySlotModelUpdatesMadeByBuilder'.
	self jobSteps verifySlotModelUpdatesMadeByBuilder
]

{ #category : #command }
LcsCodeBuilderJob >> verifyUninstall [
	self traceStep: 'verifyUninstall'.
	self jobSteps verifyUninstall
]
