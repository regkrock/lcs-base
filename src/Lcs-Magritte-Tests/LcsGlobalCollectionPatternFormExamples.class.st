Class {
	#name : #LcsGlobalCollectionPatternFormExamples,
	#superclass : #LcsObjectExamples,
	#traits : 'TBlDevScripterExamples + LctDevScripterSuport',
	#classTraits : 'TBlDevScripterExamples classTrait + LctDevScripterSuport classTrait',
	#instVars : [
		'subject'
	],
	#category : #'Lcs-Magritte-Tests-Examples'
}

{ #category : #examples }
LcsGlobalCollectionPatternFormExamples >> clickOnAcceptButtonScript [
	<gtExample>
	| anAcceptId anCancelId |
	self subject: self slotCreationFormWithPrefixAndRootNameEnteredScripter.
	anAcceptId := self actionIdFor: #magritteAcceptAction.
	anCancelId := self actionIdFor: #magritteCancelAction.
	self subjectScripter
		substep: 'Click on Accept'
		do: [ :aStep | 
			self assert: self subject model slotModelBuilder jobSteps isEmpty.
			"self inStep: aStep click: anAcceptId."
			aStep requestFocus
				label: 'Focus set to Accept button';
				// anAcceptId;
				play.

			aStep
				clickStep: [ :s | 
					s
						// anAcceptId;
						onChildAt: 1 ].
			"self assert: self subject model slotModelBuilder jobSteps isNotEmpty "].
	^ self subject
]

{ #category : #examples }
LcsGlobalCollectionPatternFormExamples >> inStep: aStep click: anAcceptId [ 
	aStep requestFocus
		label: 'Focus set to Accept button';
		// anAcceptId;
		play.

	^ aStep
		clickStep: [ :s | 
			s
				// anAcceptId;
				onChildAt: 1 ]
]

{ #category : #examples }
LcsGlobalCollectionPatternFormExamples >> slotCreationForm [
	<gtExample>
	| form |
	self ensureCurrentsystemIsPrototypeSystem.
	form := LcsGlobalCollectionPatternForm newOn: LxxPrototypeSystem.
	self assert: form targetClass equals:  LxxPrototypeSystem.
	self assert: form isSlotModelBuilderNotReified.
	self assert: form slotModelBuilder class equals:  LcsDomainClassAndGlobalCollectionClassBuilderJob.
	self assert: form slotModelBuilder collectionSlotInstallationTargetClass equals: LxxPrototypeSystem.
	self assert: form slotModelBuilder classPrefix equals: 'Lcs'.
	^form
]

{ #category : #examples }
LcsGlobalCollectionPatternFormExamples >> slotCreationFormWithPrefixAndRootNameEntered [
	<gtExample>
	| form |
	form := self slotCreationFormWithPrefixEntered.
	form slotModelBuilder createForRootName: 'Foo'.
	self assert: form slotModelBuilder jobSteps isEmpty.
	^form
]

{ #category : #examples }
LcsGlobalCollectionPatternFormExamples >> slotCreationFormWithPrefixAndRootNameEnteredScripter [
	<gtExample>
	| form aScripter |
	form := self slotCreationFormWithPrefixAndRootNameEntered.
	form slotModelBuilder createForRootName: 'Foo'.
	aScripter := self
			scripterWithModel: [ form ]
			element: [ :aModel | form asGtMagritteViewModel asElement ].

	self
		assert: aScripter
		model: aScripter model
		acceptEnabled: true
		cancelEnabled: false
		buildEnabled: true.
		
	^ aScripter
]

{ #category : #examples }
LcsGlobalCollectionPatternFormExamples >> slotCreationFormWithPrefixEntered [
	<gtExample>
	| form |
	form := self slotCreationForm.
	form slotModelBuilder classPrefix: 'Lxx'.
	self assert: form targetClass equals:  LxxPrototypeSystem.
	self assert: form isSlotModelBuilderNotReified.
	self assert: form slotModelBuilder class equals:  LcsDomainClassAndGlobalCollectionClassBuilderJob.
	self assert: form slotModelBuilder collectionSlotInstallationTargetClass equals: LxxPrototypeSystem.
	self assert: form slotModelBuilder jobSteps isEmpty.
	^form
]

{ #category : #accessing }
LcsGlobalCollectionPatternFormExamples >> subject [
	^ subject
]

{ #category : #accessing }
LcsGlobalCollectionPatternFormExamples >> subject: anObject [
	subject := anObject
]

{ #category : #accessing }
LcsGlobalCollectionPatternFormExamples >> subjectScripter [
	^ self subject
]
