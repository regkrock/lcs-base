Class {
	#name : #LcsCodeBuilderStep,
	#superclass : #LcsObject,
	#instVars : [
		'parent'
	],
	#category : #'Lcs-Tools'
}

{ #category : #accessing }
LcsCodeBuilderStep >> builderJob [
	^ self parent builderJob
]

{ #category : #uninstall }
LcsCodeBuilderStep >> clearTargetClass: aClass [
	"subclasses can override"
]

{ #category : #accessing }
LcsCodeBuilderStep >> jobStepDescription [
	self printString
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

{ #category : #'gt view' }
LcsCodeBuilderStep >> stepDescription [
	^ self printString
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
