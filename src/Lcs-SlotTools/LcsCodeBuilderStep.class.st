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

{ #category : #'gt view' }
LcsCodeBuilderStep >> addAssociationsToUmlModel: aUmlModel [
	self traceStep: 'addAssociationsToUmlModel:'.
	self jobSteps addAssociationsToUmlModel: aUmlModel
]

{ #category : #'gt view' }
LcsCodeBuilderStep >> addClassesToUmlModel: aUmlModel [
	self traceStep: 'addClassesToUmlModel:'.
	self jobSteps addClassesToUmlModel: aUmlModel.
	self addClassesToUmlModel: aUmlModel
]

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

{ #category : #execute }
LcsCodeBuilderStep >> execute [
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

{ #category : #execute }
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
	^ aView mondrian
		title: 'Steps Tree';
		priority: 1;
		painting: [ :aMondrian | LcsCodeBuilderTreeView newPaintTreeOn: aMondrian context: self ];
		actionUpdateButton
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

{ #category : #'gt views' }
LcsCodeBuilderStep >> gtUMLFor: aView [
	<gtView>
	| umlModel |
	(umlModel := self umlModel) collection isEmpty 
		ifTrue: [ ^ aView empty ].

	^ aView mondrian
		title: 'UML';
		priority: 20;
		initialize: (self proposedUmlModelFor: umlModel)
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
	self traceStep: 'installCode'.
	self jobSteps installCode
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

{ #category : #accessing }
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

{ #category : #install }
LcsCodeBuilderStep >> populateSlotModel [
	self traceStep: 'populateSlotModel'.
	self jobSteps populateSlotModel
]

{ #category : #printing }
LcsCodeBuilderStep >> printJobStreamDetailsOn: aStream [
	aStream 
		nextPutAll: self printString
]

{ #category : #'gt views' }
LcsCodeBuilderStep >> proposedUmlModelFor: umlModelClasses [
	^ LcsUml new proposedUmlModelFor: umlModelClasses
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

{ #category : #trace }
LcsCodeBuilderStep >> stepNumber [
	self parent isNil ifTrue: [ ^'1'].
	^self parent stepNumberFor: self 
]

{ #category : #trace }
LcsCodeBuilderStep >> traceStep: aString [
	self traceCr: aString , '- ' , self jobStepDescription , '(' , self class name , ')'.
]

{ #category : #'gt views' }
LcsCodeBuilderStep >> umlModel [
	| umlModel |
	umlModel := LcsUmlModel new.
	self addClassesToUmlModel: umlModel.
	umlModel removeDuplicates.
	self addAssociationsToUmlModel: umlModel.
	umlModel resolveClassModelNames.
	^ umlModel
]

{ #category : #install }
LcsCodeBuilderStep >> uninstall [
	self traceStep: 'uninstall'.
	self jobSteps uninstall
]

{ #category : #install }
LcsCodeBuilderStep >> updateSlotModel [
	self traceStep: 'updateSlotModel'.
	self jobSteps updateSlotModel
]

{ #category : #install }
LcsCodeBuilderStep >> verifyCodeInstallation [
	self traceStep: 'verifyCodeInstallation'.
	self jobSteps verifyCodeInstallation
]

{ #category : #install }
LcsCodeBuilderStep >> verifyPopulateSlotModel [
	self traceStep: 'verifyPopulateSlotModel'.
	self jobSteps verifyPopulateSlotModel
]

{ #category : #install }
LcsCodeBuilderStep >> verifySlotModelUpdatesMadeByBuilder [
	self traceStep: 'verifySlotModelUpdatesMadeByBuilder'.
	self jobSteps verifySlotModelUpdatesMadeByBuilder
]

{ #category : #install }
LcsCodeBuilderStep >> verifyUninstall [
	self traceStep: 'verifyUninstall'.
	self jobSteps verifyUninstall
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
