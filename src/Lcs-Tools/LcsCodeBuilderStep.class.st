Class {
	#name : #LcsCodeBuilderStep,
	#superclass : #LcsObject,
	#instVars : [
		'parent',
		'refactorings',
		'state'
	],
	#category : #'Lcs-Tools'
}

{ #category : #refactoring }
LcsCodeBuilderStep >> addRefactoring: aRefactoring [ 
	self refactorings add: aRefactoring
]

{ #category : #printing }
LcsCodeBuilderStep >> addRefactoringTextDetailsTo: stream [ 
]

{ #category : #accessing }
LcsCodeBuilderStep >> addRefactoringsTo: allRefactorings [
	allRefactorings addAll: self refactorings
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

{ #category : #accessing }
LcsCodeBuilderStep >> builderJob [
	^ self parent builderJob
]

{ #category : #uninstall }
LcsCodeBuilderStep >> clearTargetClass: aClass [
	"subclasses can override"
]

{ #category : #private }
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

{ #category : #initialize }
LcsCodeBuilderStep >> initialize [ 
	super initialize.
	self state: 'Initial'.
	self refactorings: OrderedCollection new
]

{ #category : #accessing }
LcsCodeBuilderStep >> jobStepDescription [
	| stream |
	stream := self jobStepDescriptionStream.
	self printJobStreamDetailsOn: stream.
	^ stream contents
]

{ #category : #accessing }
LcsCodeBuilderStep >> jobStepDescriptionStream [
	^ (WriteStream on: String new)
			nextPutAll: self stepNumber;
			nextPutAll: ') ';
			yourself 
]

{ #category : #accessing }
LcsCodeBuilderStep >> jobSteps [
	self subclassResponsibility
]

{ #category : #accessing }
LcsCodeBuilderStep >> parent [
	^ parent
]

{ #category : #accessing }
LcsCodeBuilderStep >> parent: anObject [
	parent := anObject
]

{ #category : #accessing }
LcsCodeBuilderStep >> populateSlotModel [
	"Subclasses should implement as needed"
]

{ #category : #accessing }
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

{ #category : #accessing }
LcsCodeBuilderStep >> verifyPopulateSlotModel [
	"Subclasses should implement as needed"
]

{ #category : #uninstall }
LcsCodeBuilderStep >> verifySlotModelUpdatesMadeByBuilder [
	self subclassResponsibility
]

{ #category : #accessing }
LcsCodeBuilderStep >> verifyUnistall [
	"Subclasses should implement as needed"
]

{ #category : #'gt view' }
LcsCodeBuilderStep >> viewClassButtonFor: aClass [
	^ BrButton new
		id: GtCoderBrowseCoderButtonId;
		aptitude: BrGlamorousButtonWithIconAptitude;
		label: 'Browse';
		icon: BrGlamorousVectorIcons emphasizedBrowse;
		action: [ :aButton | 
			aButton phlow spawnTool: (GtClassCoderTool forClass: aClass) ]
]

{ #category : #'gt view' }
LcsCodeBuilderStep >> viewCodeButton [
	^ BrButton new
]
