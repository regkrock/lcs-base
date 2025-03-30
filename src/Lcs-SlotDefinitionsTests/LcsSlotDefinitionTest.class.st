Class {
	#name : #LcsSlotDefinitionTest,
	#superclass : #LcsTestCase,
	#category : #'Lcs-SlotDefinitionsTests-Tests'
}

{ #category : #tests }
LcsSlotDefinitionTest >> testAddingValidationCondition [
	| validationCondition |
	validationCondition := LcsValidationCondition new
							description: 'Test';
							conditionBlock: [ :value | ];
							yourself.
	self subject: LcsSlotDefinition new.
	self subject addValidationCondition: validationCondition.
	self assert: self subject validationConditions collection size equals: 1.
	self assert: self subject validationConditions collection any parent identicalTo: self subject validationConditions.
]

{ #category : #tests }
LcsSlotDefinitionTest >> testAddingValidationConditionAndDescription [
	self subject: LcsSlotDefinition new.
	self subject addValidationCondition: [ :value | ] description: 'Test'.
	self assert: self subject validationConditions collection size equals: 1.
	self assert: self subject validationConditions collection any parent identicalTo: self subject validationConditions.
]

{ #category : #tests }
LcsSlotDefinitionTest >> testCreation [

	self subject: LcsSlotDefinition new.
	self assert: self subject slotTypes isEmpty.
	self assert: self subject slotName isNil.
	self subject slotName: #test.
	self assert: self subject slotName equals: #test.
	self subject addSlotType: Date.
	self assert: (self subject slotTypes includes: Date).
	self assert: (self subject validationConditions isKindOf: LcsValidationConditions).
	self assert: self subject validationConditions parent identicalTo: self subject.
	self assert: self subject validationConditions hasNoElements
	
]

{ #category : #tests }
LcsSlotDefinitionTest >> testRemovingValidationCondition [
	| validationCondition |
	validationCondition := LcsValidationCondition new
							description: 'Test';
							conditionBlock: [ :value | ];
							yourself.

	self subject: LcsSlotDefinition new.
	self subject addValidationCondition: validationCondition.
	self assert: self subject validationConditions collection size equals: 1.
	self subject removeValidationCondition: validationCondition.
	self assert: self subject validationConditions hasNoElements.
]

{ #category : #tests }
LcsSlotDefinitionTest >> testRemovingValidationConditionViaDescription [
	self subject: LcsSlotDefinition new.
	self subject addValidationCondition: [ :value | ] description: 'Test'.
	self assert: self subject validationConditions collection size equals: 1.
	self subject removeValidationConditionWithDescription: 'Test'.
	self assert: self subject validationConditions hasNoElements.
]

{ #category : #tests }
LcsSlotDefinitionTest >> testValidationWithNoValidationConditions [
	self subject: LcsSlotDefinition new.
	self shouldnt: (self subject validate: 'abc') raise: LcsSlotValidationError
]

{ #category : #tests }
LcsSlotDefinitionTest >> testValidationWithOneFailingValidationConditions [
	self subject: LcsSlotDefinition new.
	self subject addValidationCondition: [:value | value isInteger ] description: 'Must be an Ingeter'.
	self should: [ self subject validate: 'abc' ] raise: LcsSlotValidationError

]

{ #category : #tests }
LcsSlotDefinitionTest >> testValidationWithOnePassingValidationConditions [
	self subject: LcsSlotDefinition new.
	self subject addValidationCondition: [:value | value isInteger ] description: 'Must be an Ingeter'.
	self shouldnt: [ self subject validate: 1 ] raise: LcsSlotValidationError
]
