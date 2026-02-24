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
	self assert: slot slotTypes isEmpty.
	^ slot
]

{ #category : 'examples' }
LcsAccessorSlotExamples >> accessorSlotWithBasicPostUpdateActions [
	<gtExample>
	| accessorSlot |
	accessorSlot := self accessorSlot.
	accessorSlot slotName: 'test'.
	accessorSlot addPostUpdateAction: (LcsUpdateSiblingWithCollectionDefault new).
	self assert: accessorSlot postUpdateActions collection size equals: 1.
	^ accessorSlot
]

{ #category : 'examples' }
LcsAccessorSlotExamples >> accessorSlotWithDummyPostUpdateAction [
	<gtExample>
	| accessorSlot |
	accessorSlot := self accessorSlot.
	self addDummyPostUpdateActionTo: accessorSlot.
	^ accessorSlot
]

{ #category : 'examples' }
LcsAccessorSlotExamples >> accessorSlotWithDummyValidationAction [
	<gtExample>
	| accessorSlot |
	accessorSlot := self accessorSlot.
	self addDummyValidationActionTo: accessorSlot.
	^ accessorSlot
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

{ #category : 'support' }
LcsAccessorSlotExamples >> addDummyPostUpdateActionTo: accessorSlot [
	| updateAction |
	updateAction := LcsUpdateAction new
			description: 'Test';
			actionBlock: [ :value |  ];
			yourself.
	accessorSlot addPostUpdateAction: updateAction.
	self assert: accessorSlot postUpdateActions collectionSize equals: 1.
	self assert: updateAction parent == accessorSlot postUpdateActions.
	self assert: accessorSlot postUpdateActions any == updateAction
]

{ #category : 'support' }
LcsAccessorSlotExamples >> addDummyValidationActionTo: accessorSlot [
	| validationCondition |
	validationCondition := LcsValidationCondition new
			validationDescription: 'Test';
			conditionBlock: [ :value |  ];
			yourself.
	accessorSlot addValidationCondition: validationCondition.
	self assert: accessorSlot validationConditions collectionSize equals: 1.
	self assert: validationCondition parent == accessorSlot validationConditions.
	self assert: accessorSlot validationConditions any == validationCondition
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

{ #category : 'validation' }
LcsAccessorSlotExamples >> validateAccessorStyleSlot: slot [
	self assert: slot properties notEmpty.
	self assert: slot slotName isNil.
	self assert: slot slotTypes class = OrderedCollection.
	
	self assert: (slot validationConditions isKindOf: LcsValidationConditions).
	self assert: slot validationConditions parent equals: slot.
	self assert: slot validationConditions isEmpty.

	self assert: slot allowNil == false.
	self assert: slot allowNull == false.
	self assert: slot required == false.

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
]
