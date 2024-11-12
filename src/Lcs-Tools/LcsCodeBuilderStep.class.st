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
LcsCodeBuilderStep >> shortDescription [
	^ self printString
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

	| button |
	button := BrButton new
				id: GtCoderBrowseCoderButtonId;
				aptitude: BrGlamorousButtonWithIconAptitude;
				label: 'Browse';
				icon: BrGlamorousVectorIcons emphasizedBrowse;
				action: [ :aButton :aModel :anEvent | 
					anEvent modifiers isPrimaryModifier
						ifTrue: [ aClass gtBrowseFromButton: aButton ]
						ifFalse: [ aButton phlow
									spawnTool: (GtPhlowValuableTool new
											name: aClass gtDisplayString;
											valuable: [ | aCoder |
												aButton phlow firstParentCoderNavigationModel
													coderDo: [ :oldCoder | aCoder := GtCoderElement forCoder: oldCoder asNewCoderModelWithSameSubject ].
												aCoder ]) ] ].
	button viewModel
		when: BlClickEvent
		do: [ :anEvent | 
				anEvent modifiers isPrimaryModifier
					ifTrue: [ button viewModel clickEvent: anEvent ] ].
	button viewModel
		when: BlMouseEnterEvent
		do: [ :anEvent | 
			anEvent consumed: true.
			anEvent modifiers isPrimaryModifier
				ifTrue: [ anEvent target mouseCursor: BlCopyCursor new ]
				ifFalse: [ anEvent target mouseCursor: nil ].
			anEvent target requestFocus ].
	^ button 
]

{ #category : #'gt view' }
LcsCodeBuilderStep >> viewCodeButton [
	^ BrButton new
]
