Class {
	#name : #LcsCodeBuilderStep,
	#superclass : #LcsObject,
	#instVars : [
		'parent',
		'refactorings'
	],
	#category : #'Lcs-Tools'
}

{ #category : #accessing }
LcsCodeBuilderStep >> addRefactoringsTo: allRefactorings [
	allRefactorings addAll: self refactorings
]

{ #category : #accessing }
LcsCodeBuilderStep >> builderJob [
	^ self parent builderJob
]

{ #category : #uninstall }
LcsCodeBuilderStep >> clearTargetClass: aClass [
	"subclasses can override"
]

{ #category : #'as yet unclassified' }
LcsCodeBuilderStep >> initialize [ 
	super initialize.
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
			nextPutAll: ')';
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

{ #category : #accessing }
LcsCodeBuilderStep >> refactorings [
	^ refactorings
]

{ #category : #accessing }
LcsCodeBuilderStep >> refactorings: anObject [
	refactorings := anObject
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

{ #category : #install }
LcsCodeBuilderStep >> verifySlotModelUpdates [
	self subclassResponsibility
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
