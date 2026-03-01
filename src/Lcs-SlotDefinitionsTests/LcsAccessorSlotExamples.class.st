Class {
	#name : 'LcsAccessorSlotExamples',
	#superclass : 'LcsObjectExamples',
	#category : 'Lcs-SlotDefinitionsTests-Examples',
	#package : 'Lcs-SlotDefinitionsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsAccessorSlotExamples >> accessorSlot [
	<gtExample>
	| slot |
	slot := LcsAccessorSlot new.
	self validateAccessorStyleSlot: slot.
	^ slot
]

{ #category : 'examples' }
LcsAccessorSlotExamples >> accessorSlotIsRequired [
	<gtExample>
	| slot |
	slot := self accessorSlot.
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
	slot := self accessorSlot.
	slot slotName: 'test'.
	self assert: slot slotName equals: 'test'.
	^ slot
]

{ #category : 'examples' }
LcsAccessorSlotExamples >> accessorSlotWithAddedPostUpdateAction [
	<gtExample>
	| accessorSlot |
	accessorSlot := self accessorSlot.
	accessorSlot slotName: 'test'.
	accessorSlot addPostUpdateAction: self updateSiblingWithCollectionDefaultAction.
	self assert: accessorSlot postUpdateActions collection size equals: 1.
	^ accessorSlot
]

{ #category : 'examples' }
LcsAccessorSlotExamples >> accessorSlotWithDateSlotType [
	<gtExample>
	| slot |
	slot := self accessorSlot.
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
	slot := self accessorSlot.
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
	accessorSlot := self accessorSlot.
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
	| accessorSlot validationCondition |
	accessorSlot := self accessorSlot.
	validationCondition := self dummyValidationCondition.
	accessorSlot addValidationCondition: validationCondition.
	self assert: accessorSlot validationConditions collectionSize equals: 1.
	self assert: validationCondition parent == accessorSlot validationConditions.
	self assert: accessorSlot validationConditions any == validationCondition.
	^ accessorSlot
]

{ #category : 'examples' }
LcsAccessorSlotExamples >> accessorSlotWithDummyValidationActionRemoved [
	<gtExample>
	| slot validationCondition |
	slot := self accessorSlotWithDummyValidationAction.
	validationCondition := slot validationConditions any.
	slot removeValidationConditionWithDescription: 'Test'.
	self assert: slot validationConditions hasNoElements.
	^ slot
]

{ #category : 'examples' }
LcsAccessorSlotExamples >> accessorSlotWithInitialValueSetToNil [
	<gtExample>
	| slot |
	slot := self accessorSlot.
	slot initialValue: nil.
	self assert: slot initialValueBlock printString equals: '[ :parentDomainObject :slot | nil ]'.
	self assert: (slot initialValueBlock cull: self cull: self) isNil.
	^ slot
]

{ #category : 'examples' }
LcsAccessorSlotExamples >> accessorSlotWithIntegerValidationError [
	<gtExample>
	| slot validationCondition|
	slot := self accessorSlot.
	validationCondition := slot addValidationCondition: [ :value | value isInteger not ] description: 'Must be an Integer'.
	self assert: slot validationConditions collection size equals: 1.
	self assert: slot validationConditions collection any identicalTo: validationCondition.
	self assert: validationCondition validationDescription = 'Must be an Integer'.
	^ [ slot validate: 'text' ] on: LcsSlotValidationError do: [ :s | s return: s ]
]

{ #category : 'examples' }
LcsAccessorSlotExamples >> accessorSlotWithIntegerValidationErrorInThirdCondition [
	<gtExample>
	| slot |
	slot := self accessorSlot.
	slot addValidationCondition: [ :value | value isInteger not ] description: 'Must be an Ingeter'.
	slot addValidationCondition: [ :value | value < 2 ] description: 'Must be greater than 1'.
	slot addValidationCondition: [ :value | value > 10 ] description: 'Must be less than 11'.
	^ [ slot validate: 12 ] on: LcsSlotValidationError do: [ :s | s return: s ]
]

{ #category : 'examples' }
LcsAccessorSlotExamples >> accessorSlotWithIntegerValidationWithValidRangeOf2To10 [
	<gtExample>
	| slot |
	slot := self accessorSlot.

	slot addValidationCondition: [ :value | value isInteger not ] description: 'Must be an Ingeter'.
	self shouldnt: [ slot validate: 1 ] raise: LcsSlotValidationError.
	self should: [ slot validate: 'text' ] raise: LcsSlotValidationError.

	slot addValidationCondition: [ :value | value < 2 ] description: 'Must be greater than 1'.
	self should: [ slot validate: 1 ] raise: LcsSlotValidationError.
	self shouldnt: [ slot validate: 2 ] raise: LcsSlotValidationError.
	
	slot addValidationCondition: [ :value | value > 10 ] description: 'Must be less than 11'.
	self should: [ slot validate: 1 ] raise: LcsSlotValidationError.
	self shouldnt: [ slot validate: 2 ] raise: LcsSlotValidationError.
	self should: [ slot validate: 11 ] raise: LcsSlotValidationError.
	^ slot
]

{ #category : 'examples' }
LcsAccessorSlotExamples >> accessorSlotWithNilAllowed [
	<gtExample>
	| slot |
	slot := self accessorSlot.
	slot beAllowNil.
	self assert: slot isNilAllowed.
	slot beDisallowNil.
	self deny: slot isNilAllowed.
	slot beAllowNil.
	^ slot
]

{ #category : 'examples' }
LcsAccessorSlotExamples >> accessorSlotWithPostUpdateActions [
	<gtExample>
	| accessorSlot |
	accessorSlot := self accessorSlot.
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
	slot := self accessorSlot.
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
	slot := self accessorSlot.
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
	slot := self accessorSlot.
	self assert: slot prevalidationTransformBlock asString equals: '[ :value :slot | value ]'.
	magritteDescription := slot prevalidationTransformBlockDescription.
	self assert: (magritteDescription read: slot) equals: 'value'.
	magritteDescription write: '0' to: slot.
	self assert: (magritteDescription read: slot) equals: '0'.
	self assert: slot prevalidationTransformBlock asString equals: '[ :value :slot | 0 ]'.
	^ slot
]

{ #category : 'examples' }
LcsAccessorSlotExamples >> dateRangeSlot [
	<gtExample>
	| slot |
	slot := LcsDateRangeSlot new.
	self validateAccessorStyleSlot: slot.
	self assert: slot slotTypes size = 1.
	self assert: slot slotTypes first = LcsDateRange.
	self assert: slot effectiveDate = (Date newDay: 1 month: 1 year: 1970).
	self assert: slot expiryDate = (Date newDay: 31 month: 12 year: 2100).
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
LcsAccessorSlotExamples >> dummyValidationCondition [
	<gtExample>
	| validationCondition |
	validationCondition := LcsValidationCondition new
			validationDescription: 'Test';
			conditionBlock: [ :value |  ];
			yourself.
	self assert: validationCondition validationDescription equals: 'Test'.
	self assert: validationCondition conditionBlock printString equals: '[ :value |  ]'.
	^ validationCondition
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
	self assert: (slot validationConditions isKindOf: LcsValidationConditions).
	self assert: slot validationConditions parent equals: slot.
	self assert: slot validationConditions isEmpty.

	self deny: slot isNilAllowed.
	self deny: slot allowNull.
	self deny: slot isRequired.

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
	self shouldnt: [ slot validate: 'abc' ] raise: LcsSlotValidationError description: 'Slot has no validation conditions'
]
