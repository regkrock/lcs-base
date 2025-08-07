Class {
	#name : #LcsAccessorSlotCreationFormExamples,
	#superclass : #Object,
	#traits : 'TBlDevScripterExamples + LctDevScripterSuport',
	#classTraits : 'TBlDevScripterExamples classTrait + LctDevScripterSuport classTrait',
	#instVars : [
		'subject'
	],
	#category : #'Lcs-Magritte-Tests-Examples'
}

{ #category : #form }
LcsAccessorSlotCreationFormExamples >> accessorSlotCreationForm [
	<gtExample>
	| form |
	form := LcsAccessorSlotCreationForm new targetClass: LxxPerson.
	self assert: form slotClassName isEmpty.
	self assert: form isSlotModelBuilderNotReified.
	^form
]

{ #category : #asking }
LcsAccessorSlotCreationFormExamples >> actionIdFor: aDescriptionSymbol [
	^ GtMagritteActionElementId new description: (self subjectScripterModel perform: aDescriptionSymbol)
]

{ #category : #form }
LcsAccessorSlotCreationFormExamples >> booleanSlotAccessorSlotCreationForm [
	<gtExample>
	| form |
	form := LcsAccessorSlotCreationFormExamples new accessorSlotCreationForm
				slotClassChangedTo: 'LcsBooleanSlot'.
	self assert: form slotClassName equals: 'LcsBooleanSlot'.
	self assert: form slotModelBuilder class equals: LcsBooleanSlotBuilder.
	self assert: form slotClassDescription notNil.
	self assert: form targetClassDescription notNil.
	self assert: form slotNameDescription notNil.
	self assert: form allowNilDescription notNil.
	#(#slotClassDescription #targetClassDescription #slotNameDescription #allowNilDescription #requiredDescription initialValueBlockDescription prevalidationTransformBlockDescription validationConditionsDescription slotTypesDescription numberOfDecimalsDescription) 
		do: [ :eachDescriptionSelector | (form perform: eachDescriptionSelector) notNil ].
	#() 
		do: [ :eachDescriptionSelector | self assert: (form perform: eachDescriptionSelector) isNil ].
	^ form
]

{ #category : #asking }
LcsAccessorSlotCreationFormExamples >> currentCacheValueOf: slotClassDescription [ 
	^ (((self subjectScripter element userData at: #gtmemento) cache
		at: slotClassDescription) ifSome: [ :aValue | aValue ]) currentValue.
]

{ #category : #form }
LcsAccessorSlotCreationFormExamples >> dateOfBirthSlotAccessorSlotCreationForm [
	<gtExample>
	| form |
	form := LcsAccessorSlotCreationFormExamples new accessorSlotCreationForm
				slotClassChangedTo: 'LcsDateOfBirthSlot'.
	self assert: form slotClassName equals: 'LcsDateOfBirthSlot'.
	self assert: form slotModelBuilder class equals: LcsDateSlotBuilder.
	self assert: form slotClassDescription notNil.
	self assert: form targetClassDescription notNil.
	self assert: form slotNameDescription notNil.
	self assert: form allowNilDescription notNil.
	#(#slotClassDescription #targetClassDescription #slotNameDescription #allowNilDescription #requiredDescription initialValueBlockDescription prevalidationTransformBlockDescription validationConditionsDescription slotTypesDescription numberOfDecimalsDescription) 
		do: [ :eachDescriptionSelector | (form perform: eachDescriptionSelector) notNil ].
	#() 
		do: [ :eachDescriptionSelector | self assert: (form perform: eachDescriptionSelector) isNil ].
	^ form
]

{ #category : #form }
LcsAccessorSlotCreationFormExamples >> dateSlotAccessorSlotCreationForm [
	<gtExample>
	| form |
	form := LcsAccessorSlotCreationFormExamples new accessorSlotCreationForm
				slotClassChangedTo: 'LcsDateSlot'.
	self assert: form slotClassName equals: 'LcsDateSlot'.
	self assert: form slotModelBuilder class equals: LcsDateSlotBuilder.
	self assert: form slotClassDescription notNil.
	self assert: form targetClassDescription notNil.
	self assert: form slotNameDescription notNil.
	self assert: form allowNilDescription notNil.
	#(#slotClassDescription #targetClassDescription #slotNameDescription #allowNilDescription #requiredDescription initialValueBlockDescription prevalidationTransformBlockDescription validationConditionsDescription slotTypesDescription numberOfDecimalsDescription) 
		do: [ :eachDescriptionSelector | (form perform: eachDescriptionSelector) notNil ].
	#() 
		do: [ :eachDescriptionSelector | self assert: (form perform: eachDescriptionSelector) isNil ].
	^ form
]

{ #category : #asking }
LcsAccessorSlotCreationFormExamples >> fieldIdFor: aDescriptionSymbol [
	^ GtMagritteFieldElementId new description: (self subjectScripterModel perform: aDescriptionSymbol)
]

{ #category : #examples }
LcsAccessorSlotCreationFormExamples >> formClickOnAcceptAfterEnteringASlotClassName [
	<gtExample>
	<return: #BlScripter>
	| anAcceptId anCancelId fieldId slotClassDescription margritteAcceptAction |
	self subjectScripter: self formScripter.

	anAcceptId := self actionIdFor: #magritteAcceptAction.
	anCancelId := self actionIdFor: #magritteCancelAction.
	fieldId := self fieldIdFor: #slotClassDescription.
	slotClassDescription := self subjectScripterModel slotClassDescription.
	margritteAcceptAction := self subjectScripterModel magritteAcceptAction.

	self subjectScripter
		substep: 'Enter slot class name'
		do: [ :aStep | 
			self assert: (self currentCacheValueOf: slotClassDescription) isEmpty.
			self assert: (self originalCacheValueOf: slotClassDescription) isEmpty.
			self assert: self subjectScripterModel slotClassName isEmpty.

			self
				inStep: aStep
				enterText: 'LcsStringSlot'
				in: fieldId
				acceptEnabled: true
				acceptId: anAcceptId
				cancelEnabled: true
				cancelId: anCancelId.

			self
				assert: (self currentCacheValueOf: slotClassDescription)
				equals: 'LcsStringSlot'.
			self
				assert: (self originalCacheValueOf: slotClassDescription)
				equals: 'LcsStringSlot'.
			self assert: self subjectScripterModel slotClassName equals: 'LcsStringSlot'.

			self inStep: aStep click: anAcceptId.
			self
				assert: (self currentCacheValueOf: slotClassDescription)
				equals: 'LcsStringSlot'.
			self
				assert: (self originalCacheValueOf: slotClassDescription)
				equals: 'LcsStringSlot'.

			aStep do
				label: 'Process the apply action - simulating apply button''s action';
				referenceSender;
				action: [ :aTarget :aUserData :aScripter | 
					margritteAcceptAction action action
						value: aScripter model
						value: aTarget
						value: (aTarget userData at: #gtmemento)
						value: aScripter model magritteAcceptAction	"button" ];
				play.

			self
				assert: (self currentCacheValueOf: slotClassDescription)
				equals: 'LcsStringSlot'.
			self
				assert: (self originalCacheValueOf: slotClassDescription)
				equals: 'LcsStringSlot'.

			aStep do
				label: 'Refresh form - this is not working - maybe a timing issue';
				// anAcceptId;
				block: [ :aButton | aButton phlow fireViewUpdateWish ];
				play ].

	^ self subjectScripter
]

{ #category : #examples }
LcsAccessorSlotCreationFormExamples >> formScripter [
	<gtExample>
	<return: #BlScripter>
	self
		subjectScripter: (self
				scripterWithModel: [ self accessorSlotCreationForm ]
				element: [ :aModel | aModel asGtMagritteViewModel asElement ]).

	self
		assert: self subjectScripter
		model: self subjectScripterModel
		acceptEnabled: false
		cancelEnabled: true.

	^ self subjectScripter
]

{ #category : #examples }
LcsAccessorSlotCreationFormExamples >> formWithInvalidSlotClassNameEntry [
	<gtExample>
	<return: #BlScripter>
	| aSlotClassDescriptionId anAcceptId anCancelId |
	self subjectScripter: self formScripter.

	aSlotClassDescriptionId := self fieldIdFor: #slotClassDescription.
	anAcceptId := self actionIdFor: #magritteAcceptAction.
	anCancelId := self actionIdFor: #magritteCancelAction.

	self subjectScripter
		substep: 'Enter invalid slot class name'
		do: [ :aStep | 
			self
				inStep: aStep
				enterText: 'asdfasdf'
				in: aSlotClassDescriptionId
				acceptEnabled: false
				acceptId: anAcceptId
				cancelEnabled: true
				cancelId: anCancelId ].
	^ self subjectScripter
]

{ #category : #examples }
LcsAccessorSlotCreationFormExamples >> formWithValidSlotClassNameEntry [
	<gtExample>
	<return: #BlScripter>
	| aSlotClassDescriptionId |
	self subjectScripter: self formScripter.

	aSlotClassDescriptionId := self fieldIdFor: #slotClassDescription.

	self subjectScripter
		substep: 'Enter slot class name'
		do: [ :aStep | 
			self
				inStep: aStep
				enterText: 'LcsStringSlot'
				in: aSlotClassDescriptionId
				acceptEnabled: true
				acceptId: (self actionIdFor: #magritteAcceptAction)
				cancelEnabled: true
				cancelId: (self actionIdFor: #magritteCancelAction) ].

	^ self subjectScripter
]

{ #category : #'scripter - support' }
LcsAccessorSlotCreationFormExamples >> inStep: aStep click: anAcceptId [
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

{ #category : #'scripter - support' }
LcsAccessorSlotCreationFormExamples >> inStep: aStep enterText: aString in: anId acceptEnabled: anAcceptEnabled acceptId: anAcceptId cancelEnabled: aCancelEnabled cancelId: aCancelId [

	aStep requestFocus
		label: 'Focus set to Slot Class Name field';
		// anId;
		play.

	aStep type
		label: 'Enter slot class name';
		text: aString;
		// anId;
		play.

	aStep assert
		label: 'Check the Slot Class Name was entered';
		value: [ :anElement | 
				(anElement memento cache at: anElement fieldViewModel description)
					ifSome: [ :a | a currentValue ] ]
			equals: aString;
		// anId;
		play.
		
	self
		assert: aStep
		acceptEnabled: anAcceptEnabled
		cancelEnabled: aCancelEnabled
		acceptId: anAcceptId
		cancelId: aCancelId 
]

{ #category : #form }
LcsAccessorSlotCreationFormExamples >> integerSlotAccessorSlotCreationForm [
	<gtExample>
	| form |
	form := LcsAccessorSlotCreationFormExamples new accessorSlotCreationForm
				slotClassChangedTo: 'LcsIntegerSlot'.
	self assert: form slotClassName equals: 'LcsIntegerSlot'.
	self assert: form slotModelBuilder class equals: LcsIntegerSlotBuilder.
	self assert: form slotClassDescription notNil.
	self assert: form targetClassDescription notNil.
	self assert: form slotNameDescription notNil.
	self assert: form allowNilDescription notNil.
	#(#slotClassDescription #targetClassDescription #slotNameDescription #allowNilDescription #requiredDescription initialValueBlockDescription prevalidationTransformBlockDescription validationConditionsDescription slotTypesDescription) 
		do: [ :eachDescriptionSelector | self assert: (form perform: eachDescriptionSelector) notNil ].
	#(numberOfDecimalsDescription) 
		do: [ :eachDescriptionSelector | self assert: (form perform: eachDescriptionSelector) isNil ].
	^ form
]

{ #category : #asking }
LcsAccessorSlotCreationFormExamples >> originalCacheValueOf: slotClassDescription [ 
	^ (((self subjectScripter element userData at: #gtmemento) cache
		at: slotClassDescription) ifSome: [ :aValue | aValue ]) originalValue.
]

{ #category : #form }
LcsAccessorSlotCreationFormExamples >> scaledDecimalSlotAccessorSlotCreationForm [
	<gtExample>
	| form |
	form := LcsAccessorSlotCreationFormExamples new accessorSlotCreationForm
				slotClassChangedTo: 'LcsScaledDecimalSlot'.
	self assert: form slotClassName equals: 'LcsScaledDecimalSlot'.
	self assert: form slotModelBuilder class equals: LcsScaledDecimalSlotBuilder.
	self assert: form slotClassDescription notNil.
	self assert: form targetClassDescription notNil.
	self assert: form slotNameDescription notNil.
	self assert: form allowNilDescription notNil.
	#(#slotClassDescription #targetClassDescription #slotNameDescription #allowNilDescription #requiredDescription initialValueBlockDescription prevalidationTransformBlockDescription validationConditionsDescription slotTypesDescription numberOfDecimalsDescription) 
		do: [ :eachDescriptionSelector | (form perform: eachDescriptionSelector) notNil ].
	#() 
		do: [ :eachDescriptionSelector | self assert: (form perform: eachDescriptionSelector) isNil ].
	^ form
]

{ #category : #form }
LcsAccessorSlotCreationFormExamples >> stringSlotAccessorSlotCreationForm [
	<gtExample>
	| form |
	form := LcsAccessorSlotCreationFormExamples new accessorSlotCreationForm
				slotClassChangedTo: 'LcsStringSlot'.
	self assert: form slotClassName equals: 'LcsStringSlot'.
	self assert: form slotModelBuilder class equals: LcsStringSlotBuilder.
	self assert: form slotClassDescription notNil.
	self assert: form targetClassDescription notNil.
	self assert: form slotNameDescription notNil.
	self assert: form allowNilDescription notNil.
	#(#slotClassDescription #targetClassDescription #slotNameDescription #allowNilDescription #requiredDescription initialValueBlockDescription prevalidationTransformBlockDescription validationConditionsDescription slotTypesDescription ) 
		do: [ :eachDescriptionSelector | (form perform: eachDescriptionSelector) notNil ].
	#(numberOfDecimalsDescription) 
		do: [ :eachDescriptionSelector | self assert: (form perform: eachDescriptionSelector) isNil ].
	^ form
]

{ #category : #examples }
LcsAccessorSlotCreationFormExamples >> stringSlotSubjectScripter [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self
			scripterWithModel: [ self stringSlotAccessorSlotCreationForm ]
			element: [ :aModel | aModel asGtMagritteViewModel asElement ].

	self
		assert: aScripter
		model: aScripter model
		acceptEnabled: false
		cancelEnabled: true
		buildEnabled: false.
		
	^ aScripter
]

{ #category : #accessing }
LcsAccessorSlotCreationFormExamples >> subject [
	^ subject
]

{ #category : #accessing }
LcsAccessorSlotCreationFormExamples >> subject: aScripter [
	subject := aScripter
]

{ #category : #accessing }
LcsAccessorSlotCreationFormExamples >> subjectScripter [
	^ self subject
]

{ #category : #accessing }
LcsAccessorSlotCreationFormExamples >> subjectScripter: aScripter [
	self subject: aScripter
]

{ #category : #accessing }
LcsAccessorSlotCreationFormExamples >> subjectScripterModel [
	^ self subjectScripter model
]

{ #category : #form }
LcsAccessorSlotCreationFormExamples >> symbolSlotAccessorSlotCreationForm [
	<gtExample>
	| form |
	form := LcsAccessorSlotCreationFormExamples new accessorSlotCreationForm
				slotClassChangedTo: 'LcsSymbolSlot'.
	self assert: form slotClassName equals: 'LcsSymbolSlot'.
	self assert: form slotModelBuilder class equals: LcsStringSlotBuilder.
	self assert: form slotClassDescription notNil.
	self assert: form targetClassDescription notNil.
	self assert: form slotNameDescription notNil.
	self assert: form allowNilDescription notNil.
	#(#slotClassDescription #targetClassDescription #slotNameDescription #allowNilDescription #requiredDescription initialValueBlockDescription prevalidationTransformBlockDescription validationConditionsDescription slotTypesDescription ) 
		do: [ :eachDescriptionSelector | (form perform: eachDescriptionSelector) notNil ].
	#(numberOfDecimalsDescription) 
		do: [ :eachDescriptionSelector | self assert: (form perform: eachDescriptionSelector) isNil ].
	^ form
]
