Class {
	#name : #LcsGlobalCollectionPatternFormExamples,
	#superclass : #LcsMagritteFormExamples,
	#category : #'Lcs-Magritte-Tests-Examples'
}

{ #category : #'scripter - assertion' }
LcsGlobalCollectionPatternFormExamples >> assert: aStep model: aModel acceptEnabled: isAcceptEnabled cancelEnabled: isCancelEnabled [
	| anAcceptId anCancelId |
	anAcceptId := GtMagritteActionElementId new
			description: aModel magritteAcceptAction.
	anCancelId := GtMagritteActionElementId new
			description: aModel magritteCancelAction.
	self
		assert: aStep
		acceptEnabled: isAcceptEnabled
		cancelEnabled: isCancelEnabled
		acceptId: anAcceptId
		cancelId: anCancelId
]

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
						onChildAt: 1 ] ].
	^ self subject
]

{ #category : #examples }
LcsGlobalCollectionPatternFormExamples >> fooSlotCreationFormExample [
	<gtExample>
	| form |
	self ensureCurrentsystemIsPrototypeSystem.
	form := LcsGlobalCollectionPatternForm newOn: LxxPrototypeSystem.
	form slotModelBuilder targetPackageName: 'Lcs-Temp'.
	form slotModelBuilder targetPackageTagName: 'Core'.
	form slotModelBuilder classPrefix: 'Lxx'.
	form slotModelBuilder classRootName: 'Foo'.
	form slotModelBuilder targetDomainClasses: (OrderedCollection with: LxxPerson).
	self simulateClickOnAcceptButtonIn: form.
	^ form
]

{ #category : #examples }
LcsGlobalCollectionPatternFormExamples >> formScripter [
	<gtExample>
	<return: #BlScripter>
	| builder |
	self ensureCurrentsystemIsPrototypeSystem.
	self
		subjectScripter: (self
				scripterWithModel: [ self slotCreationForm ]
				element: [ :aModel | aModel asGtMagritteViewModel asElement ]).

	self
		assert: self subjectScripter
		model: self subjectScripterModel
		acceptEnabled: false
		cancelEnabled: true.
		
	self
		validateEntryOf: 'Lxx'
		into: (self fieldIdFor: #classNamePrefixDescription)
		resultingAccept: false
		cancel: true.

	self assert: (self currentValueOf: #classNamePrefixDescription) equals: 'Lxx'.
	self assert: (self previousValueOf: #classNamePrefixDescription) equals: 'Lcs'.

	builder := self subjectScripterModel slotModelBuilder.
	self assert: builder jobSteps isEmpty.
	self assert: builder classRootName equals: nil.
	self assert: builder classPrefix equals: 'Lcs'.
	self assert: self subjectScripterModel slotModelBuilder classPrefix equals: 'Lcs'.
	self assert: builder collectionSlotName equals: nil.
	self assert: builder domainInstanceSlotName equals: nil.
	self assert: builder newDomainClassName equals: nil.
	self assert: builder collectionClassName equals: nil.
	self assert: builder targetPackageName equals: 'Lcs-Temp'.
	self assert: builder targetPackageTagName equals: 'Core'.
	self assert: builder targetDomainClasses isEmpty.
	^ self subjectScripter
]

{ #category : #examples }
LcsGlobalCollectionPatternFormExamples >> formScripterWithRootNameEntered [
	<gtExample>
	<return: #BlScripter>

	self subjectScripter: self formScripter.
	self
		validateEntryOf: 'Foo'
		into: (self fieldIdFor: #classRootNameDescription)
		resultingAccept: false
		cancel: true.

	self
		validateEntryOf: 'foo'
		into: (self fieldIdFor: #domainInstanceSlotNameDescription)
		resultingAccept: true
		cancel: true.
		
	self assert: (self currentValueOf: #classRootNameDescription) equals: 'Foo'.
	self assert: (self previousValueOf: #classRootNameDescription) equals: nil.
	self assert: self subjectScripterModel slotModelBuilder classRootName equals: nil.
	self assert: self subjectScripterModel slotModelBuilder jobSteps isEmpty.

	^ self subjectScripter
]

{ #category : #examples }
LcsGlobalCollectionPatternFormExamples >> formScripterWithRootNameEnteredAndBuildUnknownClassChecked [
	<gtExample>
	<return: #BlScripter>
	self subjectScripter: self formScripterWithRootNameEntered.
	self clickOn: (self fieldIdFor: #buildUnknownClassDescription).
	self assert: (self currentValueOf: #buildUnknownClassDescription) equals: true.
	self assert: (self previousValueOf: #buildUnknownClassDescription) equals: false.
	self assert: self subjectScripterModel slotModelBuilder buildUnknownClass equals: false.
	self assert: self subjectScripterModel slotModelBuilder jobSteps isEmpty.
	^ self subjectScripter
]

{ #category : #examples }
LcsGlobalCollectionPatternFormExamples >> formScripterWithRootNameEnteredAndBuildUnknownClassCheckedAndClickAccept [
	<gtExample>
	<return: #BlScripter>
	| builder |

	self subjectScripter: self formScripterWithRootNameEnteredAndBuildUnknownClassChecked.
	builder := self subjectScripterModel slotModelBuilder.
	self assert: builder jobSteps isEmpty.

	"self clickOn: (self actionIdFor: #magritteAcceptAction)."
	"self simulateClickOnAcceptButtonAction."
	
	self assert:  builder domainInstanceSlotName isNil.
	self subjectScripterMemento commit.
	self assert:  builder domainInstanceSlotName equals: 'foo'.

	self subjectScripter model buildJobSteps.
	
	self assert: builder jobSteps isNotEmpty.
	self assert: builder jobSteps numberOfSteps equals: 6.
	self assert:  builder classPrefix equals: 'Lxx'.
	self assert:  builder collectionSlotName equals: 'foos'.
	self assert:  builder domainInstanceSlotName equals: 'foo'.
	self assert:  builder newDomainClassName equals: 'LxxFoo'.
	self assert:  builder collectionClassName equals: 'LxxFoos'.

	^ self subjectScripter
]

{ #category : #examples }
LcsGlobalCollectionPatternFormExamples >> formScripterWithRootNameEnteredAndBuildUnknownClassCheckedAndClickAcceptAndThenUnslectBuildUnknownAndClickAccept [
	<gtExample>
	<return: #BlScripter>
	| builder |

	self subjectScripter: self formScripterWithRootNameEnteredAndBuildUnknownClassCheckedAndClickAccept.
	builder := self subjectScripterModel slotModelBuilder.
	self assert: builder jobSteps numberOfSteps equals: 6.

	self clickOn: (self fieldIdFor: #buildUnknownClassDescription).
	self clickOn: (self actionIdFor: #magritteAcceptAction).
	
	self assert: builder jobSteps isNotEmpty.
	self assert: builder jobSteps numberOfSteps equals: 5.
	self assert:  builder classPrefix equals: 'Lxx'.
	self assert:  builder collectionSlotName equals: 'foos'.
	self assert:  builder domainInstanceSlotName equals: 'foo'.
	self assert:  builder newDomainClassName equals: 'LxxFoo'.
	self assert:  builder collectionClassName equals: 'LxxFoos'.

	^ self subjectScripter
]

{ #category : #examples }
LcsGlobalCollectionPatternFormExamples >> formScripterWithRootNameEnteredAndBuildUnknownClassCheckedAndClickAcceptAndThenUnslectBuildUnknownAndClickAcceptModel [
	<gtExample>
	self subjectScripter: self formScripterWithRootNameEnteredAndBuildUnknownClassCheckedAndClickAcceptAndThenUnslectBuildUnknownAndClickAccept.
	^ self subjectScripterModel
]

{ #category : #examples }
LcsGlobalCollectionPatternFormExamples >> simulateClickOnAcceptButtonIn: form [
	self
		subjectScripter: (self
				scripterWithModel: [ form ]
				element: [ :aModel | aModel asGtMagritteViewModel asElement ]).
	self clickOn: (self actionIdFor: #magritteAcceptAction)
]

{ #category : #examples }
LcsGlobalCollectionPatternFormExamples >> slotCreationForm [
	<gtExample>
	| form |
	self ensureCurrentsystemIsPrototypeSystem.
	form := LcsGlobalCollectionPatternForm newOn: LxxPrototypeSystem.
	form slotModelBuilder targetPackageName: 'Lcs-Temp'.
	form slotModelBuilder targetPackageTagName: 'Core'.
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
		cancelEnabled: true
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
