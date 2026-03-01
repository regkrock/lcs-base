Class {
	#name : 'LcsStringSlotExamples',
	#superclass : 'LcsObjectExamples',
	#category : 'Lcs-SlotDefinitionsTests-Examples',
	#package : 'Lcs-SlotDefinitionsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsStringSlotExamples >> lstNameStringSlot [
	<gtExample>
	| slot |
	self ensureCurrentSystemIsPrototypeSystem.
	slot := (LxxPerson slotModel slotDefinitionNamed: 'lastName').
	self assert: (slot isKindOf: LcsStringSlot).
	self assert: slot slotName equals: 'lastName'.
	^ slot
]

{ #category : 'tests' }
LcsStringSlotExamples >> personWithEmptyLastName [
	<gtExample>
	| person |
	self ensureCurrentSystemIsPrototypeSystem.
	person := LxxPerson new.
	self assert: person lastName isEmpty.
	^ person
]

{ #category : 'examples' }
LcsStringSlotExamples >> personWithLastNameOfSchmidt [
	<gtExample>
	| person |
	person := self personWithEmptyLastName.
	person lastName: 'Schmidt'.
	self assert: person isInAddingState.
	self assert: person lastName equals: 'Schmidt'.
	self assert: ((person slotDefinitionNamed: 'lastName') persistedSlotVarIn: person) equals: 'Schmidt'.
	self currentSystem applyChanges.
	self assert: ((person slotDefinitionNamed: 'lastName') persistedSlotVarIn: person) equals: 'Schmidt'.
	person
]
