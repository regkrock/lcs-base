Class {
	#name : 'LcsAccessorSlotExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-SlotDefinitionsTests-Examples',
	#package : 'Lcs-SlotDefinitionsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsAccessorSlotExamples >> accessorSlotIsRequired [
	<gtExample>
	| slot |
	slot := self newSlot.
	self deny: slot isRequired.
	slot beRequired.
	self assert: slot isRequired.
	slot beOptional.
	self deny: slot isRequired.
	slot beRequired.
	self assert: slot isRequired.
	^ slot
]

{ #category : 'examples' }
LcsAccessorSlotExamples >> accessorSlotNamedTest [
	<gtExample>
	| slot |
	slot := self newSlot.
	slot slotName: 'test'.
	self assert: slot slotName equals: 'test'.
	^ slot
]

{ #category : 'examples - errors' }
LcsAccessorSlotExamples >> accessorSlotPropertyError [
	<gtExample>
	<noTest>
	| slot |
	slot := self newSlot.
	self should: [ slot propertyAt: #'test' ] raise: LcsSlotPropertyError.
	^ slot propertyAt: #'test'.
]

{ #category : 'examples' }
LcsAccessorSlotExamples >> accessorSlotWithAddedPostUpdateAction [
	<gtExample>
	| accessorSlot |
	accessorSlot := self newSlot.
	accessorSlot slotName: 'test'.
	accessorSlot addPostUpdateAction: self updateSiblingWithCollectionDefaultAction.
	self assert: accessorSlot postUpdateActions collection size equals: 1.
	^ accessorSlot
]

{ #category : 'examples' }
LcsAccessorSlotExamples >> accessorSlotWithDateSlotType [
	<gtExample>
	| slot |
	slot := self newSlot.
	slot slotName: 'test'.
	self assert: slot slotName equals: 'test'.
	slot addSlotType: Date.
	self assert: slot slotTypes size equals: 1.
	self assert: (slot slotTypes includes: Date).
	slot addSlotType: Object.
	self assert: slot slotTypes size equals: 2.
	self assert: (slot slotTypes includes: Object).
	slot removeSlotType: Object.
	self assert: slot slotTypes size equals: 1.
	self assert: (slot slotTypes includes: Date).
	self should: [ slot addSlotType: 'Date' ] raise: AssertionFailure.
	^ slot
]

{ #category : 'examples' }
LcsAccessorSlotExamples >> accessorSlotWithDirectVariableUpdatePolicy [
	<gtExample>
	| slot |
	slot := self newSlot.
	self assert: slot variableUpdatePolicyClass equals: LcsUnitOfWorkVariableUpdatePolicy.
	slot makeDirectUpdateOfVariable.
	self assert: slot variableUpdatePolicyClass equals: LcsDirectVariableUpdatePolicy.
	self assert: (slot variableUpdatePolicy isKindOf: LcsDirectVariableUpdatePolicy).
	slot makeUpdateOfVariableViaUnitOfWork.
	self assert: slot variableUpdatePolicyClass equals: LcsUnitOfWorkVariableUpdatePolicy.
	self assert: (slot variableUpdatePolicy isKindOf: LcsUnitOfWorkVariableUpdatePolicy).
	slot makeDirectUpdateOfVariable.
	^ slot
]

{ #category : 'examples' }
LcsAccessorSlotExamples >> accessorSlotWithDummyPostUpdateAction [
	<gtExample>
	| accessorSlot updateAction |
	accessorSlot := self newSlot.
	updateAction := self dummyPostUpdateAction.
	accessorSlot addPostUpdateAction: updateAction.
	self assert: accessorSlot postUpdateActions collectionSize equals: 1.
	self assert: updateAction parent == accessorSlot postUpdateActions.
	self assert: accessorSlot postUpdateActions any == updateAction.
	^ accessorSlot
]

{ #category : 'examples' }
LcsAccessorSlotExamples >> accessorSlotWithDummyPostUpdateActionRemoved [
	<gtExample>
	| slot updateAction |
	slot := self accessorSlotWithDummyPostUpdateAction.
	self assert: slot postUpdateActions collectionSize equals: 1.
	updateAction := slot postUpdateActions collection any.
	slot removeAction: updateAction.
	self assert: slot postUpdateActions collectionSize equals: 0.
	^ slot
]

{ #category : 'examples' }
LcsAccessorSlotExamples >> accessorSlotWithDummyValidationAction [
	<gtExample>
	| accessorSlot rule |
	accessorSlot := self newSlot.
	rule := self dummyValidationRule.
	accessorSlot addValidationRule: rule.
	self assert: accessorSlot validationRules collectionSize equals: 1.
	self assert: rule parent == accessorSlot validationRules.
	self assert: accessorSlot validationRules any == rule.
	^ accessorSlot
]

{ #category : 'examples' }
LcsAccessorSlotExamples >> accessorSlotWithDummyValidationActionRemoved [
	<gtExample>
	| slot validationRule |
	slot := self accessorSlotWithDummyValidationAction.
	validationRule := slot validationRules any.
	slot removeValidationRuleWithDescription: validationRule description.
	self assert: slot validationRules hasNoElements.
	^ slot
]

{ #category : 'examples' }
LcsAccessorSlotExamples >> accessorSlotWithInitialValueSetToNil [
	<gtExample>
	| slot |
	slot := self newSlot.
	slot initialValue: nil.
	self assert: slot initialValueBlock printString equals: '[ :parentDomainObject :slot | nil ]'.
	self assert: (slot initialValueBlock cull: self cull: self) isNil.
	^ slot
]

{ #category : 'examples - errors' }
LcsAccessorSlotExamples >> accessorSlotWithIntegerValidationError [
	<gtExample>
	<noTest>
	| slot |
	slot := self accessorSlotWithIntegerValidationRule.
	self should: [ slot validate: 'text' ] raise: LcsInvalidSlotTypeError .
	^ slot validate: 'text' 
]

{ #category : 'examples' }
LcsAccessorSlotExamples >> accessorSlotWithIntegerValidationErrorInThirdCondition [
	<gtExample>
	| slot |
	slot := self newSlot.
	slot addValidationRuleBlock: [ :value | value isInteger not ] description: 'Must be an Ingeter'.
	slot addValidationRuleBlock: [ :value | value < 2 ] description: 'Must be greater than 1'.
	slot addValidationRuleBlock: [ :value | value > 10 ] description: 'Must be less than 11'.
	^ [ slot validate: 12 ] on: LcsInvalidSlotTypeError do: [ :s | s return: s ]
]

{ #category : 'examples' }
LcsAccessorSlotExamples >> accessorSlotWithIntegerValidationRule [
	<gtExample>
	| slot rule|
	slot := self newSlot.
	rule := slot addValidationRuleBlock: [ :value | value isInteger not ] description: 'Must be an Integer'.
	self assert: slot validationRules collection size equals: 1.
	self assert: slot validationRules collection any identicalTo: rule.
	self assert: rule description = 'Must be an Integer'.
	^ slot
]

{ #category : 'examples' }
LcsAccessorSlotExamples >> accessorSlotWithIntegerValidationWithValidRangeOf2To10 [
	<gtExample>
	| slot |
	slot := self newSlot.
	self
		should: [ slot validate: 'text' ]
		raise: LcsInvalidSlotTypeError
		description: 'No slot ype defined'.
	self should: [ slot validate: 'text' ] raise: LcsInvalidSlotTypeError.

	slot addSlotType: Integer.
	self assert: (slot validate: 1).
	self assert: (slot validate: 11).
	self should: [ slot validate: 'text' ] raise: LcsInvalidSlotTypeError.

	slot
		addValidationRuleBlock: [ :value | value isInteger ]
		description: 'Must be an Ingeter'.
	self shouldnt: [ slot validate: 1 ] raise: LcsSlotValidationError.

	slot validationRules beAndEvaluationType.
	slot
		addValidationRuleBlock: [ :value | value >= 2 ]
		description: 'Must be greater than 1'.
	slot
		addValidationRuleBlock: [ :value | value < 11 ]
		description: 'Must be less than 11'.
	self assert: (slot validate: 2) description: 'Lower range boundary'.
	self assert: (slot validate: 10) description: 'Upper range boundary'.
	self
		should: [ slot validate: 1 ]
		raise: LcsSlotValidationError
		description: 'Outsisde lower range boundary'.
	self
		should: [ slot validate: 11 ]
		raise: LcsSlotValidationError
		description: 'Outsisde upper range boundary'.
	^ slot
]

{ #category : 'examples' }
LcsAccessorSlotExamples >> accessorSlotWithNilAllowed [
	<gtExample>
	| slot |
	slot := self newSlot.
	self should: [ slot validate: nil ] raise: LcsInvalidSlotTypeError.
	self should: [ slot validate: nil context: 'xxx' oldValue: nil ] raise: LcsInvalidSlotTypeError.

	slot beAllowNil.
	self assert: slot isNilAllowed.
	self assert: slot slotTypeRules collectionSize = 2.
	self assert: slot slotTypeRules first class equals: LcsAllowNilSlotTypeRule.
	self assert: slot validationRules collectionSize = 1.
	self assert: (slot validate: nil).
	self assert: (slot validate: nil context: 'xxx' oldValue: nil).
	self assert: (slot validate: nil context: 'xxx' oldValue: 'xx').
	
	slot beDisallowNil.
	self deny: slot isNilAllowed.
	self deny: slot isInitialNilAllowed.
	self assert: slot slotTypeRules collectionSize = 1.
	self deny: slot slotTypeRules first class equals: LcsAllowNilSlotTypeRule.
	self assert: slot validationRules collectionSize = 0.
	self should: [ slot validate: nil ] raise: LcsInvalidSlotTypeError.
	self should: [ slot validate: nil context: 'xxx' oldValue: nil ] raise: LcsInvalidSlotTypeError.
	
	slot beAllowNil.
	self assert: (slot validate: nil).
	^ slot
]

{ #category : 'examples' }
LcsAccessorSlotExamples >> accessorSlotWithNilAllowedOnlyAtInitialization [
	<gtExample>
	| slot |
	slot := self newSlot.
	self assert: slot slotTypes isEmpty.
	self 
		should: [ slot validate: nil ] 
		raise: LcsInvalidSlotTypeError.
	self 
		should: [ slot validate: nil context: nil oldValue: LcsApplicationEnvironment undefinedObject ] 
		raise: LcsInvalidSlotTypeError.

	"Nil is allowed only on object creation"
	slot beAllowInitialNil.
	self assert: slot isInitialNilAllowed.
	self assert: slot slotTypeRules collectionSize = 2.
	self assert: slot slotTypeRules first class equals: LcsAllowNilSlotTypeRule.
	self assert: slot validationRules collectionSize = 1.
	self  assert: (slot validate: nil context: nil oldValue: LcsApplicationEnvironment undefinedObject).
	self should: [ slot validate: nil ] raise: LcsSlotValidationError.
	self 
		shouldnt: [ slot validate: nil context: nil oldValue: LcsApplicationEnvironment undefinedObject ] 
		raise: LcsInvalidSlotTypeError.
	self 
		should: [ slot validate: nil context: nil oldValue: nil ] 
		raise: LcsSlotValidationError.


	"Nil is not only allowed on object creation"
	slot beDisallowInitialNil.
	self deny: slot isNilAllowed.
	self deny: slot isInitialNilAllowed.
	self assert: slot slotTypeRules collectionSize = 1.
	self deny: slot slotTypeRules first class equals: LcsAllowNilSlotTypeRule.
	self assert: slot validationRules collectionSize = 0.
	self should: [ slot validate: nil ] raise: LcsInvalidSlotTypeError.
	^ slot
]

{ #category : 'examples' }
LcsAccessorSlotExamples >> accessorSlotWithNullAllowedOnlyAtInitialization [
	<gtExample>
	| slot |
	slot := self newSlot.
	slot addSlotType: String.
	self 
		should: [ slot validate: nil ] 
		raise: LcsInvalidSlotTypeError.
	self 
		should: [ slot validate: nil context: nil oldValue: LcsApplicationEnvironment undefinedObject ] 
		raise: LcsInvalidSlotTypeError.

	"Nil is allowed only on object creation"
	slot beAllowInitialNull.
	self assert: slot isInitialNullAllowed.
	self assert: slot slotTypeRules collectionSize = 2.
	self assert: slot slotTypeRules first class equals: LcsAllowNullSlotTypeRule.
	self assert: slot validationRules collectionSize = 1.
	self  assert: (slot validate: '' context: nil oldValue: LcsApplicationEnvironment undefinedObject).
	self should: [ slot validate: nil ] raise: LcsInvalidSlotTypeError.
	self 
		shouldnt: [ slot validate: '' context: nil oldValue: LcsApplicationEnvironment undefinedObject ] 
		raise: LcsInvalidSlotTypeError.


	"Nil is not only allowed on object creation"
	slot beDisallowInitialNull.
	self deny: slot isNullAllowed.
	self deny: slot isInitialNullAllowed.
	self assert: slot slotTypeRules collectionSize = 1.
	self deny: slot slotTypeRules first class equals: LcsAllowNullSlotTypeRule.
	self assert: slot validationRules collectionSize = 0.
	self should: [ slot validate: nil ] raise: LcsInvalidSlotTypeError.
	^ slot
]

{ #category : 'examples' }
LcsAccessorSlotExamples >> accessorSlotWithNumberType [
	<gtExample>
	| slot |
	slot := self newSlot.
	slot addSlotType: Number.
	self deny: slot allowNil.
	self should: [ slot validate: nil ] raise: LcsInvalidSlotTypeError.
	self should: [ slot validate: nil context: nil ] raise: LcsInvalidSlotTypeError.
	self assert: (slot validate: 12 context: nil).
	^ slot
]

{ #category : 'examples' }
LcsAccessorSlotExamples >> accessorSlotWithNumberTypeVerifyingNilAllowedAndNotAllowed [
	<gtExample>
	| slot |
	slot := self accessorSlotWithNumberType.
	slot beAllowNil.
	self shouldnt: [ slot validate: nil ] raise: LcsInvalidSlotTypeError.
	self shouldnt: [ slot validate: nil context: nil ] raise: LcsInvalidSlotTypeError.
	self assert: (slot validate: nil).
	self assert: (slot validate: 12 context: nil).
	slot beDisallowNil.
	self should: [ slot validate: nil ] raise: LcsInvalidSlotTypeError.
	self should: [ slot validate: nil context: nil ] raise: LcsInvalidSlotTypeError.
	self assert: (slot validate: 12 context: nil).
	^ slot
]

{ #category : 'examples' }
LcsAccessorSlotExamples >> accessorSlotWithPostUpdateActions [
	<gtExample>
	| accessorSlot |
	accessorSlot := self newSlot.
	accessorSlot slotName: 'test'.
	accessorSlot addPostUpdateAction: (
		LcsUpdateSiblingWithCollectionDefault new 
			description: 'When country changes, update the default province';
			siblingSlotName: 'province';
			sourceCollectionSlotName: 'subdivisions';
			yourself).
	self assert: accessorSlot postUpdateActions collection size equals: 1.
	^ accessorSlot
]

{ #category : 'examples' }
LcsAccessorSlotExamples >> accessorSlotWithSlotTypesSetViaMagritteSlotTypesDescription [
	<gtExample>
	| slot magritteSlotTypeDescription|
	slot := self newSlot.
	slot addSlotType: String.
	magritteSlotTypeDescription := slot slotTypesDescription.
	self assert: (magritteSlotTypeDescription read: slot) equals: (OrderedCollection with: #String).
	magritteSlotTypeDescription write: (OrderedCollection with: #String with: #Integer) to: slot.
	self assert: slot slotTypes equals: (OrderedCollection with: String with: Integer).
	self assert: (magritteSlotTypeDescription read: slot) equals: (OrderedCollection with: #String with: #Integer).
	^ slot
]

{ #category : 'examples' }
LcsAccessorSlotExamples >> accessorSlotWithUpdatedInitialValueBlockDoneViaMagritteDescription [
	<gtExample>
	| slot magritteDescription|
	slot := self newSlot.
	slot addSlotType: String.
	magritteDescription := slot initialValueBlockDescription.
	self assert: (magritteDescription read: slot) equals: 'self newInstanceOfFirstSlotTypeIn: slot parent: parentDomainObject'.
	magritteDescription write: '0' to: slot.
	self assert: slot initialValueBlock printString equals: '[ :parentDomainObject :slot | 0 ]'.
	^ slot
]

{ #category : 'examples' }
LcsAccessorSlotExamples >> accessorSlotWithUpdatedPrevalidationTransformBlockDoneViaMagritteDescription [
	<gtExample>
	| slot magritteDescription|
	slot := self newSlot.
	self assert: slot prevalidationTransformBlock asString equals: '[ :value :slot | value ]'.
	magritteDescription := slot prevalidationTransformBlockDescription.
	self assert: (magritteDescription read: slot) equals: 'value'.
	magritteDescription write: '0' to: slot.
	self assert: (magritteDescription read: slot) equals: '0'.
	self assert: slot prevalidationTransformBlock asString equals: '[ :value :slot | 0 ]'.
	^ slot
]

{ #category : 'examples' }
LcsAccessorSlotExamples >> dummyPostUpdateAction [
	<gtExample>
	| updateAction |
	updateAction := LcsUpdateAction new
			description: 'Test';
			actionBlock: [ :value |  ];
			yourself.
	self assert: updateAction description equals: 'Test'.
	self assert: updateAction actionBlock printString equals: '[ :value |  ]'.
	^ updateAction
]

{ #category : 'examples' }
LcsAccessorSlotExamples >> dummyValidationRule [
	<gtExample>
	| rule |
	rule := LcsValidationRule new
			description: 'Test';
			conditionBlock: [ :value |  ];
			yourself.
	self assert: rule description equals: 'Test'.
	self assert: rule conditionBlock printString equals: '[ :value |  ]'.
	^ rule
]

{ #category : 'examples' }
LcsAccessorSlotExamples >> newSlot [
	<gtExample>
	| slot |
	slot := LcsAccessorSlot new.
	self validateAccessorStyleSlot: slot.
	^ slot
]

{ #category : 'examples' }
LcsAccessorSlotExamples >> updateSiblingWithCollectionDefaultAction [
	<gtExample>
	| action |
	action := LcsUpdateSiblingWithCollectionDefault new
		description: 'When country changes, update the default province';
		siblingSlotName: 'province';
		sourceCollectionSlotName: 'subdivisions';
		yourself.
	self assert: action description equals: 'When country changes, update the default province'.
	self assert: action siblingSlotName equals: 'province'.
	self assert: action sourceCollectionSlotName equals: 'subdivisions'.
	^ action
]

{ #category : 'examples' }
LcsAccessorSlotExamples >> updateSiblingWithCollectionDefaultActionGeneratedCode [
	<gtExample>
	| action stream |
	action := self updateSiblingWithCollectionDefaultAction.
	stream := LcsMethodStream new.
	stream addKeyword: 'addPostUpdateAction' withRenderedAction: action.
	self assert: stream contents equals: 'addPostUpdateAction: (
	LcsUpdateSiblingWithCollectionDefault new
		description: ''When country changes, update the default province'';
		siblingSlotName: ''province'';
		sourceCollectionSlotName: ''subdivisions'';
		yourself);'.
	^ stream contents
]

{ #category : 'examples' }
LcsAccessorSlotExamples >> updateSiblingWithCollectionModifiedActionGeneratedCode [
	<gtExample>
	| action stream |
	action := self updateSiblingWithCollectionDefaultAction.
	action actionBlock: [ :newValue :parentDomainObject :oldValue | ]. 
	stream := LcsMethodStream new.
	stream addKeyword: 'addPostUpdateAction' withRenderedAction: action.
	self assert: stream contents equals: 'addPostUpdateAction: (
	LcsUpdateSiblingWithCollectionDefault new
		description: ''When country changes, update the default province'';
		actionBlock: [ :newValue :parentDomainObject :oldValue | ];
		siblingSlotName: ''province'';
		sourceCollectionSlotName: ''subdivisions'';
		yourself);'.
	^ stream contents
]

{ #category : 'validation' }
LcsAccessorSlotExamples >> validateAccessorStyleSlot: slot [
	self assert: slot properties notEmpty.
	self assert: slot slotName isNil.
	self assert: slot slotTypes class = OrderedCollection.
	self assert: slot slotTypes isEmpty.
	self assert: (slot slotTypeRules isKindOf: LcsSlotTypeRules).
	self assert: slot slotTypeRules hasElements.
	self assert: slot slotTypeRules collection size = 1.
	self assert: (slot validationRules isKindOf: LcsValidationRules).
	self assert: slot validationRules parent equals: slot.
	self assert: slot validationRules isEmpty.

	self deny: slot isNilAllowed.
	self deny: slot allowNull.
	self deny: slot isNullAllowed.
	self deny: slot isInitialNullAllowed.
	self deny: slot isRequired.
	self assert: slot slotTypeRules collectionSize = 1.

	self assert: slot variableUpdatePolicyClass equals: LcsUnitOfWorkVariableUpdatePolicy.
	self assert: (slot variableUpdatePolicy isKindOf: LcsUnitOfWorkVariableUpdatePolicy).
	self assert: slot variableUpdatePolicy parent equals: slot.
	
	self assert: slot postUpdateActions class equals: LcsUpdateActions.
	self assert: slot postUpdateActions isEmpty.
	self assert: slot postUpdateActions parent equals: slot.

	self assert: slot initialValueBlock printString equals: '[ :parentDomainObject :slot | self newInstanceOfFirstSlotTypeIn: slot parent: parentDomainObject ]'.
			
	self assert: slot initialValueBlock printString = slot defaultInitialValueBlock printString.
	self assert: slot prevalidationTransformBlock printString = slot defaultPrevalidationTransformBlock printString.
	self assert: slot pragmaSelector = slot defaultPragmaSelector.
	self assert: slot comment isEmpty.
	self should: [ slot validate: nil ] raise: LcsInvalidSlotTypeError description: 'Slot does not allow nil'.
	self should: [ slot validate: nil context: nil ] raise: LcsInvalidSlotTypeError description: 'Slot does not allow nil'.
	self should: [ slot validate: 'abc' ] raise: LcsInvalidSlotTypeError description: 'Slot has types defined'.
	self should: [ slot validate: 'abc' context: nil ] raise: LcsInvalidSlotTypeError description: 'Slot has types defined'
]
