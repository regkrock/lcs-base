Class {
	#name : #LcsMultislotPatternFormExamples,
	#superclass : #LcsMagritteFormExamples,
	#category : #'Lcs-Magritte-Tests-Examples'
}

{ #category : #'scripter - assertion' }
LcsMultislotPatternFormExamples >> assert: aStep model: aModel acceptEnabled: isAcceptEnabled cancelEnabled: isCancelEnabled [
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

{ #category : #configuration }
LcsMultislotPatternFormExamples >> builderJobClass [
	^ self formClass builderClass
]

{ #category : #'sciprter - support' }
LcsMultislotPatternFormExamples >> clickOnAcceptButtonScript [
	<gtExample>
	<return: #BlScripter>
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

{ #category : #configuration }
LcsMultislotPatternFormExamples >> formClass [
	^ self subclassResponsibility
]

{ #category : #'examples - scripter' }
LcsMultislotPatternFormExamples >> formScripterWithRootNameEntered [
	<gtExample>
	<return: #BlScripter>

	self subjectScripter: self mainFormScripter.
	self
		validateEntryOf: 'Foo'
		into: (self fieldIdFor: #classRootNameDescription)
		resultingAccept: true
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

{ #category : #'examples - scripter' }
LcsMultislotPatternFormExamples >> formScripterWithRootNameEnteredAndBuildUnknownClassChecked [
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

{ #category : #'examples - scripter' }
LcsMultislotPatternFormExamples >> formScripterWithRootNameEnteredAndBuildUnknownClassCheckedAndClickAccept [
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

{ #category : #'examples - scripter' }
LcsMultislotPatternFormExamples >> formScripterWithRootNameEnteredAndBuildUnknownClassCheckedAndClickAcceptAndThenUnslectBuildUnknownAndClickAcceptModel [
	<gtExample>
	self subjectScripter: self formScripterWithRootNameEnteredAndBuildUnknownClassCheckedAndClickAcceptAndThenUnslectBuildUnknownAndClickAccept.
	^ self subjectScripterModel
]

{ #category : #'examples  - form' }
LcsMultislotPatternFormExamples >> mainForm [
	"<gtExample>
	<return: #LcsGlobalCollectionPatternForm>"
	| form |
	self ensureCurrentsystemIsPrototypeSystem.
	form := self formClass newOn: self targetClass.
	self assert: form isSlotModelBuilderNotReified.
	form slotModelBuilder
		targetPackageName: 'Lcs-Temp';
		targetPackageTagName: 'Core';
		classPrefix: 'Lxx'.
	self assert: form targetClass equals: self targetClass.
	self assert: form slotModelBuilder classPrefix equals: 'Lxx'.
	self assert: form slotModelBuilder class equals: self builderJobClass.
	^ form
]

{ #category : #'examples - scripter' }
LcsMultislotPatternFormExamples >> mainFormScripter [
	"<gtExample>
	<return: #BlScripter>"
	| builder |
	self ensureCurrentsystemIsPrototypeSystem.
	self
		subjectScripter: (self
				scripterWithModel: [ self mainForm ]
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
	"self assert: (self previousValueOf: #classNamePrefixDescription) equals: 'Lcs'."

	builder := self subjectScripterModel slotModelBuilder.
	self assert: builder jobSteps isEmpty.
	self assert: builder classRootName equals: nil.
	"self assert: builder classPrefix equals: 'Lcs'."
	"self assert: self subjectScripterModel slotModelBuilder classPrefix equals: 'Lcs'."
	self assert: builder collectionSlotName equals: nil.
	self assert: builder domainInstanceSlotName equals: nil.
	self assert: builder newDomainClassName equals: nil.
	self assert: builder collectionClassName equals: nil.
	self assert: builder targetPackageName equals: 'Lcs-Temp'.
	self assert: builder targetPackageTagName equals: 'Core'.
	self assert: builder targetDomainClasses isEmpty.
	^ self subjectScripter
]

{ #category : #'sciprter - support' }
LcsMultislotPatternFormExamples >> simulateClickOnAcceptButtonIn: form [
	self
		subjectScripter: (
			self
				scripterWithModel: [ form ]
				element: [ :aModel | aModel asGtMagritteViewModel asElement ]).
	self clickOn: (self actionIdFor: #magritteAcceptAction)
]

{ #category : #'examples - scripter' }
LcsMultislotPatternFormExamples >> slotCreationFormWithPrefixAndRootNameEnteredScripter [
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

{ #category : #configuration }
LcsMultislotPatternFormExamples >> targetClass [
	^ LxxPrototypeSystem
]
