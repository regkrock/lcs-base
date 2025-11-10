Class {
	#name : #LcsSlotCreationFormExamples,
	#superclass : #LcsMagritteFormExamples,
	#category : #'Lcs-Magritte-Tests-Examples'
}

{ #category : #asking }
LcsSlotCreationFormExamples >> actionIdFor: aDescriptionSymbol [
	^ GtMagritteActionElementId new description: (self subjectScripterModel perform: aDescriptionSymbol)
]

{ #category : #asking }
LcsSlotCreationFormExamples >> currentCacheValueOf: slotClassDescription [ 
	^ (((self subjectScripter element userData at: #gtmemento) cache
		at: slotClassDescription) ifSome: [ :aValue | aValue ]) currentValue.
]

{ #category : #asking }
LcsSlotCreationFormExamples >> fieldIdFor: aDescriptionSymbol [
	^ GtMagritteFieldElementId new description: (self subjectScripterModel perform: aDescriptionSymbol)
]

{ #category : #'examples - scripter' }
LcsSlotCreationFormExamples >> formClickOnAcceptAfterEnteringASlotClassName [
	<gtExample>
	<return: #BlScripter>
	| anAcceptId anCancelId fieldId slotClassDescription margritteAcceptAction |
	self ensureCurrentSystemIsPrototypeSystem.
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

{ #category : #'examples - scripter' }
LcsSlotCreationFormExamples >> formScripter [
	<gtExample>
	<return: #BlScripter>
	self ensureCurrentSystemIsPrototypeSystem.
	self
		subjectScripter: (self
				scripterWithModel: [ self slotCreationFormOnLxxPerson ]
				element: [ :aModel | aModel asGtMagritteViewModel asElement ]).

	self
		assert: self subjectScripter
		model: self subjectScripterModel
		acceptEnabled: false
		cancelEnabled: true.

	^ self subjectScripter
]

{ #category : #'examples - scripter' }
LcsSlotCreationFormExamples >> formWithInvalidSlotClassNameEntry [
	<gtExample>
	<return: #BlScripter>
	| aSlotClassDescriptionId anAcceptId anCancelId |
	self ensureCurrentSystemIsPrototypeSystem.
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

{ #category : #'examples - scripter' }
LcsSlotCreationFormExamples >> formWithValidSlotClassNameEntry [
	<gtExample>
	<return: #BlScripter>
	| aSlotClassDescriptionId |
	self ensureCurrentSystemIsPrototypeSystem.
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
LcsSlotCreationFormExamples >> inStep: aStep click: anAcceptId [
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
LcsSlotCreationFormExamples >> inStep: aStep enterText: aString in: anId acceptEnabled: anAcceptEnabled acceptId: anAcceptId cancelEnabled: aCancelEnabled cancelId: aCancelId [

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

{ #category : #asking }
LcsSlotCreationFormExamples >> originalCacheValueOf: slotClassDescription [ 
	^ (((self subjectScripter element userData at: #gtmemento) cache
		at: slotClassDescription) ifSome: [ :aValue | aValue ]) originalValue.
]

{ #category : #'examples - form' }
LcsSlotCreationFormExamples >> slotCreationForm [
	<gtExample>
	| form |
	self ensureCurrentSystemIsPrototypeSystem.
	form := LcsSlotCreationForm new targetClass: LxxPerson.
	self assert: form targetClass equals: LxxPerson.
	self assert: form slotClassName isEmpty.
	self assert: form isSlotModelBuilderNotReified.
	^form
]

{ #category : #'examples - support' }
LcsSlotCreationFormExamples >> slotCreationFormOn: aDomainClass [
	| form |
	self ensureCurrentSystemIsPrototypeSystem.
	form := LcsSlotCreationForm new 
				targetClass: aDomainClass;
				targetClassName: aDomainClass name asString.
	self assert: form targetClass equals: aDomainClass.
	self assert: form slotClassName isEmpty.
	self assert: form isSlotModelBuilderNotReified.
	^form
]

{ #category : #'example - form' }
LcsSlotCreationFormExamples >> slotCreationFormOnLxxPerson [
	<gtExample>
	| form |
	form := self slotCreationFormOn: LxxPerson.
	^ form
]

{ #category : #'example - form' }
LcsSlotCreationFormExamples >> virtualSlotAccessorSlotCreationForm [
	<gtExample>
	| form |
	self ensureCurrentSystemIsPrototypeSystem.
	form := self slotCreationFormOnLxxPerson
				slotClassChangedTo: 'LcsVirtualSlot'.
	self assert: form slotClassName equals: 'LcsVirtualSlot'.
	self assert: form slotModelBuilder class equals: LcsVirtualSlotBuilder.
	#(#slotClassDescription #targetClassDescription #slotNameDescription
	  #slotTypesDescription ) 
		do: [ :eachDescriptionSelector | (form perform: eachDescriptionSelector) notNil ].
	#(#allowNilDescription #requiredDescription #prevalidationTransformBlockDescription
	  #validationConditionsDescription #numberOfDecimalsDescription
	  #initialValueBlockDescription ) 
		do: [ :eachDescriptionSelector | self assert: (form perform: eachDescriptionSelector) isNil ].
	^ form
]
