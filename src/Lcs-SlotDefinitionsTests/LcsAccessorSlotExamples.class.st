Class {
	#name : #LcsAccessorSlotExamples,
	#superclass : #LcsObjectExamples,
	#category : #'Lcs-SlotDefinitionsTests-Examples'
}

{ #category : #examples }
LcsAccessorSlotExamples >> accessorSlot [
	<gtExample>
	| accessorSlot |
	accessorSlot := LcsAccessorSlot new.

	self assert: accessorSlot slotName isNil.
	self assert: accessorSlot slotTypes isEmpty.
	self assert: accessorSlot slotTypes class = OrderedCollection.
	
	self assert: (accessorSlot validationConditions isKindOf: LcsValidationConditions).
	self assert: accessorSlot validationConditions parent equals: accessorSlot.
	self assert: accessorSlot validationConditions hasNoElements.

	self assert: accessorSlot allowNil == false.
	self assert: accessorSlot required == false.

	self assert: accessorSlot variableUpdatePolicyClass equals: LcsUnitOfWorkVariableUpdatePolicy.
	self assert: (accessorSlot variableUpdatePolicy isKindOf: LcsUnitOfWorkVariableUpdatePolicy).
	self assert: accessorSlot variableUpdatePolicy parent equals: accessorSlot.
	
	self assert: accessorSlot postUpdateActions class equals: LcsUpdateActions.
	self assert: accessorSlot postUpdateActions hasNoElements.
	self assert: accessorSlot postUpdateActions parent equals: accessorSlot.

	self assert: accessorSlot initialValueBlock printString equals: '[ :domainObject :slot | 
		(slot slotTypes any new)
			parent: domainObject;
			yourself ]'.

	^ accessorSlot
]

{ #category : #examples }
LcsAccessorSlotExamples >> accessorSlotWithDummyPostUpdateAction [
	<gtExample>
	| accessorSlot |
	accessorSlot := self accessorSlot.
	self addDummyPostUpdateActionTo: accessorSlot.
	^ accessorSlot
]

{ #category : #examples }
LcsAccessorSlotExamples >> accessorSlotWithDummyValidationAction [
	<gtExample>
	| accessorSlot |
	accessorSlot := self accessorSlot.
	self addDummyValidationActionTo: accessorSlot.
	^ accessorSlot
]

{ #category : #examples }
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

{ #category : #support }
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

{ #category : #support }
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
