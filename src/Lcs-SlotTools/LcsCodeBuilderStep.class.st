Class {
	#name : #LcsCodeBuilderStep,
	#superclass : #LcsApplicationObject,
	#instVars : [
		'parent',
		'refactorings',
		'state',
		'jobSteps'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #building }
LcsCodeBuilderStep >> addJobStep: aJobStep [
	^ self jobSteps addJobStep: aJobStep
]

{ #category : #refactorings }
LcsCodeBuilderStep >> addRefactoring: aRefactoring [ 
	self refactorings add: aRefactoring
]

{ #category : #refactorings }
LcsCodeBuilderStep >> addRefactoringTextDetailsTo: stream [ 
]

{ #category : #refactorings }
LcsCodeBuilderStep >> addRefactoringsTo: aCollection [
	aCollection addAll: self refactorings
]

{ #category : #state }
LcsCodeBuilderStep >> beCodeInstalled [
	self state: 'Code Installed'
]

{ #category : #state }
LcsCodeBuilderStep >> beCodeVerified [
	self state: 'Code Verified'
]

{ #category : #state }
LcsCodeBuilderStep >> beSlotModelUpdated [
	self state: 'Slot Model Updated'
]

{ #category : #state }
LcsCodeBuilderStep >> beSlotModelUpdatedVerified [
	self state: 'Slot Model Verified'
]

{ #category : #building }
LcsCodeBuilderStep >> buildJobSteps [
	^ self jobSteps buildJobSteps
]

{ #category : #'builder job' }
LcsCodeBuilderStep >> builderJob [
	^ self parent builderJob
]

{ #category : #uninstall }
LcsCodeBuilderStep >> clearTargetClass: aClass [
	"subclasses can override"
]

{ #category : #command }
LcsCodeBuilderStep >> fullyInstall [
	"If this is part of a builder job, then do not use this. Let the builder control the phases"
	self 
		installCode;
		verifyCodeInstallation;
		updateSlotModel;
		verifySlotModelUpdatesMadeByBuilder;
		populateSlotModel;
		verifyPopulateSlotModel
]

{ #category : #'gt views' }
LcsCodeBuilderStep >> gtConstructionTreeFor: aView [
	<gtView>
	self jobSteps isEmpty ifTrue: [^ aView empty ].
	^ aView mondrian
		title: 'Steps Tree';
		priority: 1;
		painting: [ :aMondrian | LcsCodeBuilderTreeView newPaintTreeOn: aMondrian context: self ]
]

{ #category : #'gt views' }
LcsCodeBuilderStep >> gtPaintTreeWith: aMondrian [
	self
		withDeep: [ :each | 
			each jobSteps collect: [ :eachStep | eachStep ] ]
		do: [ :each | 
			aMondrian nodes
				stencil: [ :eachJobStep | self jobStepPane: eachJobStep ];
				with: {each} ]
		relationDo: [ :from :to | 
			aMondrian edges
				fromRightCenter;
				toLeftCenter;
				stencil: [ :x | self jobStepPaneAssociation ];
				connectAssociations: {from -> to} ].
	aMondrian layout
		custom: (GtGraphHorizontalTreeLayout new
					levelDistance: 50;
					nodeDistance: 20).
	aMondrian
]

{ #category : #initialize }
LcsCodeBuilderStep >> initialize [ 
	super initialize.
	self state: 'Initial'.
	self refactorings: OrderedCollection new.
	self jobSteps: (LcsCodeBuilderJobSteps newOn: self)
]

{ #category : #install }
LcsCodeBuilderStep >> installCode [
	self subclassResponsibility
]

{ #category : #printing }
LcsCodeBuilderStep >> jobStepDescription [
	| stream |
	stream := self jobStepDescriptionStream.
	self printJobStreamDetailsOn: stream.
	^ stream contents
]

{ #category : #printing }
LcsCodeBuilderStep >> jobStepDescriptionStream [
	^ (WriteStream on: String new)
			nextPutAll: self stepNumber;
			nextPutAll: ') ';
			yourself 
]

{ #category : #'gt views' }
LcsCodeBuilderStep >> jobStepPane: aJobStep [
	^ BrVerticalPane new
		fitContent;
		addChild: (BrLabel new
				text: aJobStep class name;
				aptitude: (BrGlamorousLabelAptitude new
						foreground: Color gray;
						fontSize: 10));
		addChild: (BrLabel new
				text: aJobStep jobStepDescription;
				aptitude: BrGlamorousLabelAptitude new)
]

{ #category : #'gt views' }
LcsCodeBuilderStep >> jobStepPaneAssociation [
	^ BlParabollaArcElement new
		zIndex: 0;
		curvatureFraction: 0.0;
		border: (BlBorder paint: (Color gray alpha: 0.2) width: 2);
		toHead: (BlArrowheadSimpleArrow new
				border: (BlBorder builder
						paint: (Color gray alpha: 0.2);
						width: 4;
						build))
]

{ #category : #building }
LcsCodeBuilderStep >> jobSteps [
	^ jobSteps
]

{ #category : #accessing }
LcsCodeBuilderStep >> jobSteps: anObject [
	jobSteps := anObject
]

{ #category : #accessing }
LcsCodeBuilderStep >> parent [
	^ parent
]

{ #category : #accessing }
LcsCodeBuilderStep >> parent: anObject [
	parent := anObject
]

{ #category : #command }
LcsCodeBuilderStep >> populateSlotModel [
	"Subclasses should implement as needed"
]

{ #category : #printing }
LcsCodeBuilderStep >> printJobStreamDetailsOn: aStream [
	aStream 
		nextPutAll: self printString
]

{ #category : #printing }
LcsCodeBuilderStep >> refactoringText [
	| stream |
	stream := WriteStream on: String new.
	self addRefactoringTextDetailsTo: stream.
	^ stream contents
]

{ #category : #accessing }
LcsCodeBuilderStep >> refactorings [
	^ refactorings
]

{ #category : #accessing }
LcsCodeBuilderStep >> refactorings: anObject [
	refactorings := anObject
]

{ #category : #uninstall }
LcsCodeBuilderStep >> reverseRefactorings [
	self refactorings reverseDo: [ :each | each execute ]
]

{ #category : #accessing }
LcsCodeBuilderStep >> state [
	^ state
]

{ #category : #accessing }
LcsCodeBuilderStep >> state: anObject [
	state := anObject
]

{ #category : #install }
LcsCodeBuilderStep >> uninstall [
	"Subclass can override"
]

{ #category : #install }
LcsCodeBuilderStep >> updateSlotModel [
	self subclassResponsibility
]

{ #category : #install }
LcsCodeBuilderStep >> verifyCodeInstallation [
	self subclassResponsibility
]

{ #category : #command }
LcsCodeBuilderStep >> verifyPopulateSlotModel [
	"Subclasses should implement as needed"
]

{ #category : #uninstall }
LcsCodeBuilderStep >> verifySlotModelUpdatesMadeByBuilder [
	self subclassResponsibility
]

{ #category : #install }
LcsCodeBuilderStep >> verifyUninstall [
	self subclassResponsibility
]

{ #category : #command }
LcsCodeBuilderStep >> verifyUnistall [
	"Subclasses should implement as needed"
]

{ #category : #'gt views' }
LcsCodeBuilderStep >> viewClassButtonFor: aClass [
	^ BrButton new
		id: GtCoderBrowseCoderButtonId;
		aptitude: BrGlamorousButtonWithIconAptitude;
		label: 'Browse';
		icon: BrGlamorousVectorIcons emphasizedBrowse;
		action: [ :aButton | 
			aButton phlow spawnTool: (GtClassCoderTool forClass: aClass) ]
]

{ #category : #'gt views' }
LcsCodeBuilderStep >> viewCodeButton [
	^ BrButton new
]
