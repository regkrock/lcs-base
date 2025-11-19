Class {
	#name : 'LcsCodeBuilderJob',
	#superclass : 'LcsApplicationObject',
	#instVars : [
		'jobSteps',
		'buildUnknownClass',
		'umlPositions'
	],
	#category : 'Lcs-SlotTools',
	#package : 'Lcs-SlotTools'
}

{ #category : 'gt views' }
LcsCodeBuilderJob >> addAssociationsToUmlModel: aUmlModel [ 
	self traceStep: 'addAssociationsToUmlModel:'.
	 self jobSteps addAssociationsToUmlModel: aUmlModel 
]

{ #category : 'gt views' }
LcsCodeBuilderJob >> addClassesToUmlModel: aUmlModel [ 
	self traceStep: 'addClassesToUmlModel:'.
	self jobSteps addClassesToUmlModel: aUmlModel 
]

{ #category : 'configuration' }
LcsCodeBuilderJob >> addJobStep: aJobStep [ 
	^ self jobSteps addJobStep: aJobStep
]

{ #category : 'gt views' }
LcsCodeBuilderJob >> addRefactoringTextDetailsTo: aStream [
	self jobSteps do: [ :each |
		aStream nextPutAll: '---- Step: ' , each stepNumber , ' ----'; cr; cr.
		each addRefactoringTextDetailsTo: aStream ] separatedBy: [ aStream cr; cr ]
]

{ #category : 'refactorings' }
LcsCodeBuilderJob >> addRefactoringsTo: aCollection [ 
	self jobSteps addRefactoringsTo: aCollection 
]

{ #category : 'command' }
LcsCodeBuilderJob >> buildJobSteps [
	"subclasses can override this"
]

{ #category : 'accessing' }
LcsCodeBuilderJob >> buildUnknownClass [
	^ buildUnknownClass
]

{ #category : 'accessing' }
LcsCodeBuilderJob >> buildUnknownClass: aBoolean [ 
	buildUnknownClass := aBoolean
]

{ #category : 'asking' }
LcsCodeBuilderJob >> builderJob [
	^self
]

{ #category : 'refactorings' }
LcsCodeBuilderJob >> completedRefactorings [
	| allRefactorings |
	allRefactorings := OrderedCollection new.
	self addRefactoringsTo: allRefactorings.
	^ allRefactorings
]

{ #category : 'command' }
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

{ #category : 'configuration' }
LcsCodeBuilderJob >> generateRelatedNames [
]

{ #category : 'gt views' }
LcsCodeBuilderJob >> gtClassBuilderViewFor: aView [
	<gtView>
	^ aView columnedTree
		title: 'Steps List';
		priority: 10;
		expandUpTo: 2;
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

{ #category : 'gt views' }
LcsCodeBuilderJob >> gtConstructionTreeFor: aView [
	<gtView>
	^ aView mondrian
		title: 'Steps Tree';
		priority: 1;
		painting: [ :aMondrian | LcsCodeBuilderTreeView newPaintTreeOn: aMondrian context: self ];
		actionUpdateButton
]

{ #category : 'gt views' }
LcsCodeBuilderJob >> gtExecutionViewFor: aView [
	<gtView>
	^ (LcsCodeBuilderJob>>#execute gtSourceFor: aView)
			title: 'Execution';
			priority: 15

]

{ #category : 'gt views' }
LcsCodeBuilderJob >> gtPaintUMLWith: aMondrian [ 
	aMondrian initialize: #LcsSlotModelDiagramExamples asClass new domainObjectSlotModel
]

{ #category : 'gt views' }
LcsCodeBuilderJob >> gtRefactoringChangeOn: aView [
	<gtView>
	^ aView text
		title: 'Refactoring';
		priority: 1;
		text: [ self refactoringText asRopedText ];
		actionUpdateButton
]

{ #category : 'gt views' }
LcsCodeBuilderJob >> gtUMLFor: aView [
	<gtView>
	^ aView mondrian
		title: 'UML';
		priority: 20;
		tooltip: 'Existing Classes: gray, Proposed Classes: blue, Newly Created: brown';
		initialize: self umlModelMondrianView;
		send: [ :item | item modelClass ifNil: [ item ] ];
		actionUpdateButton
]

{ #category : 'initialize' }
LcsCodeBuilderJob >> initialize [
	super initialize.
	self umlPositions: OrderedCollection new.
	self initializeJobSteps
]

{ #category : 'initialize' }
LcsCodeBuilderJob >> initializeJobSteps [
	self jobSteps: (LcsCodeBuilderJobSteps newOn: self)
]

{ #category : 'command' }
LcsCodeBuilderJob >> installCode [
	self traceStep: 'installCode'.
	self jobSteps installCode
]

{ #category : 'gt views' }
LcsCodeBuilderJob >> jobStepDescription [
	| stream |
	stream := WriteStream on: String new.
	self printJobStreamDetailsOn: stream.
	^ stream contents
]

{ #category : 'accessing' }
LcsCodeBuilderJob >> jobSteps [
	^ jobSteps
]

{ #category : 'accessing' }
LcsCodeBuilderJob >> jobSteps: anObject [
	jobSteps := anObject
]

{ #category : 'gt views' }
LcsCodeBuilderJob >> modelAssociations [
	| associations |
	associations := OrderedCollection new.
	self jobSteps addAssociationsToUmlModel: associations.
	^ associations
]

{ #category : 'command' }
LcsCodeBuilderJob >> populateSlotModel [
	self traceStep: 'populateSlotModel'.
	self jobSteps populateSlotModel.
	self currentSystem currentUnitOfWork applyChanges
]

{ #category : 'gt views' }
LcsCodeBuilderJob >> printJobStreamDetailsOn: aStream [
	aStream nextPutAll: self printString

]

{ #category : 'gt views' }
LcsCodeBuilderJob >> proposedUmlModelFor: aUmlModel [
	^ LcsUml new proposedUmlModelFor: aUmlModel
]

{ #category : 'gt views' }
LcsCodeBuilderJob >> refactoringText [
	| stream |
	stream := WriteStream on: String new.
	self addRefactoringTextDetailsTo: stream.
	^ stream contents
]

{ #category : 'asking' }
LcsCodeBuilderJob >> stepNumber [
	^ ''
]

{ #category : 'command' }
LcsCodeBuilderJob >> traceStep: aMethodName [
	LcsBuilderLogger log: aMethodName , '-' , self printString
]

{ #category : 'gt views' }
LcsCodeBuilderJob >> umlModel [
	| umlModel |
	umlModel := LcsUmlModel new .
	umlModel positions: self umlPositions.
	self addClassesToUmlModel: umlModel.
	umlModel removeDuplicates.
	self addAssociationsToUmlModel: umlModel.
	umlModel resolveClassModelNames.
	^ umlModel
]

{ #category : 'gt views' }
LcsCodeBuilderJob >> umlModelMondrianView [
	^ self proposedUmlModelFor: self umlModel
]

{ #category : 'accessing' }
LcsCodeBuilderJob >> umlPositions [
	^ umlPositions
]

{ #category : 'accessing' }
LcsCodeBuilderJob >> umlPositions: anObject [
	umlPositions := anObject
]

{ #category : 'command' }
LcsCodeBuilderJob >> uninstall [
	self traceStep: 'uninstall'.
	self jobSteps uninstall.
	self currentUnitOfWork ifNotNil: [ :each | each applyChanges ]
]

{ #category : 'command' }
LcsCodeBuilderJob >> updateSlotModel [
	self traceStep: 'updateSlotModel'.
	self currentSystem isNil ifTrue: [ ^ self ].
	self jobSteps updateSlotModel.
	self currentSystem currentUnitOfWork applyChanges	
]

{ #category : 'command' }
LcsCodeBuilderJob >> verifyCodeInstallation [
	self traceStep: 'verifyCodeInstallation'.
	self jobSteps verifyCodeInstallation
]

{ #category : 'command' }
LcsCodeBuilderJob >> verifyPopulateSlotModel [
	self jobSteps verifyPopulateSlotModel
]

{ #category : 'command' }
LcsCodeBuilderJob >> verifySlotModelUpdatesMadeByBuilder [
	self traceStep: 'verifySlotModelUpdatesMadeByBuilder'.
	self jobSteps verifySlotModelUpdatesMadeByBuilder
]

{ #category : 'command' }
LcsCodeBuilderJob >> verifyUninstall [
	self traceStep: 'verifyUninstall'.
	self jobSteps verifyUninstall
]
