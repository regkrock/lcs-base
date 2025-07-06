Class {
	#name : #LcsAccessorSlotTest,
	#superclass : #LcsTestCase,
	#category : #'Lcs-SlotDefinitionsTests-Tests'
}

{ #category : #tests }
LcsAccessorSlotTest >> testAddingValidationCondition [
	| validationCondition |
	validationCondition := LcsValidationCondition new
							description: 'Test';
							conditionBlock: [ :value | ];
							yourself.
	self subject: LcsAccessorSlot new.
	self subject addValidationCondition: validationCondition.
	self assert: self subject validationConditions collectionSize equals: 1.
	self assert: self subject validationConditions collection any parent identicalTo: self subject validationConditions.
]

{ #category : #tests }
LcsAccessorSlotTest >> testAddingValidationConditionAndDescription [
	self subject: LcsAccessorSlot new.
	self subject addValidationCondition: [ :value | ] description: 'Test'.
	self assert: self subject validationConditions collection size equals: 1.
	self assert: self subject validationConditions collection any parent identicalTo: self subject validationConditions.
]

{ #category : #testing }
LcsAccessorSlotTest >> testAllowNil [
	self subject: LcsAccessorSlot new.
	self assert: self subject allowNil == false.
	self deny: self subject isNilAllowed.
	self subject beAllowNil.
	self assert: self subject allowNil == true.
	self assert: self subject isNilAllowed
]

{ #category : #tests }
LcsAccessorSlotTest >> testCreation [

	self subject: LcsAccessorSlot new.
	self assert: self subject slotTypes isEmpty.
	self assert: self subject slotName isNil.
	self subject slotName: #test.
	self assert: self subject slotName equals: #test.
	self subject addSlotType: Date.
	self assert: (self subject slotTypes includes: Date).
	self assert: (self subject validationConditions isKindOf: LcsValidationConditions).
	self assert: self subject validationConditions parent identicalTo: self subject.
	self assert: self subject validationConditions hasNoElements.
	self assert: self subject allowNil == false.
	self assert: self subject required == false.
	
]

{ #category : #testing }
LcsAccessorSlotTest >> testInitalValueSetToNil [
	self subject: LcsAccessorSlot new.
	self assert: self subject initialValueBlock printString equals: '[ :parentDomainObject | 
		(self slotTypes any new)
			parent: parentDomainObject;
			yourself ]'.
	self subject initialValue: nil.
	self assert: self subject initialValueBlock printString equals: '[ :domainObject :slot | nil ]'.
	self assert: (self subject initialValueBlock cull: self cull: self) isNil
]

{ #category : #tests }
LcsAccessorSlotTest >> testRemovingValidationCondition [
	| validationCondition |
	validationCondition := LcsValidationCondition new
							description: 'Test';
							conditionBlock: [ :value | ];
							yourself.

	self subject: LcsAccessorSlot new.
	self subject addValidationCondition: validationCondition.
	self assert: self subject validationConditions collection size equals: 1.
	self subject removeValidationCondition: validationCondition.
	self assert: self subject validationConditions hasNoElements.
]

{ #category : #tests }
LcsAccessorSlotTest >> testRemovingValidationConditionViaDescription [
	self subject: LcsAccessorSlot new.
	self subject addValidationCondition: [ :value | ] description: 'Test'.
	self assert: self subject validationConditions collection size equals: 1.
	self subject removeValidationConditionWithDescription: 'Test'.
	self assert: self subject validationConditions hasNoElements.
]

{ #category : #testing }
LcsAccessorSlotTest >> testRequried [
	self subject: LcsAccessorSlot new.
	self assert: self subject isRequired not.
	self subject beRequired.
	self assert: self subject isRequired.
	self subject beOptional.
	self assert: self subject isRequired not
]

{ #category : #testing }
LcsAccessorSlotTest >> testSlotTypes [
	self subject: LcsAccessorSlot new.
	self assert: self subject slotTypes isEmpty.
	self assert: self subject slotTypes class == OrderedCollection.
	self subject slotTypes: Array new.
	self assert: self subject slotTypes class == Array.

]

{ #category : #testing }
LcsAccessorSlotTest >> testValidationConditions [
	self subject: LcsAccessorSlot new.
	self assert: self subject validationConditions class == LcsValidationConditions.
	self assert: self subject validationConditions hasNoElements.
]

{ #category : #tests }
LcsAccessorSlotTest >> testValidationWithNoValidationConditions [
	self subject: LcsAccessorSlot new.
	self shouldnt: (self subject validate: 'abc') raise: LcsSlotValidationError
]

{ #category : #tests }
LcsAccessorSlotTest >> testValidationWithOneFailingValidationConditions [
	self subject: LcsAccessorSlot new.
	self subject addValidationCondition: [:value | value isInteger ] description: 'Must be an Ingeter'.
	self should: [ self subject validate: 'abc' ] raise: LcsSlotValidationError

]

{ #category : #tests }
LcsAccessorSlotTest >> testValidationWithOnePassingValidationConditions [
	self subject: LcsAccessorSlot new.
	self subject addValidationCondition: [:value | value isInteger ] description: 'Must be an Ingeter'.
	self shouldnt: [ self subject validate: 1 ] raise: LcsSlotValidationError
]
