Class {
	#name : 'LcsStringSlotTest',
	#superclass : 'LcsPrototypeSystemRunningTest',
	#category : 'Lcs-SlotDefinitionsTests-Tests',
	#package : 'Lcs-SlotDefinitionsTests',
	#tag : 'Tests'
}

{ #category : 'tests' }
LcsStringSlotTest >> testInstallation [
	subject := LxxPerson slotModel slotDefinitionNamed: 'lastName'.
	self assert: subject slotName equals: 'lastName'.
	self assert: subject class == LcsStringSlot
]

{ #category : 'tests' }
LcsStringSlotTest >> testSlotGetter [
	| person |
	person := LxxPerson new.
	self assert: person lastName isEmpty.
]

{ #category : 'tests' }
LcsStringSlotTest >> testSlotSetter [
	| person |
	person := LxxPerson new.
	self assert: person lastName isEmpty.
	person lastName: 'Schmidt'.
	self assert: person isInAddingState.
	self assert: person lastName equals: 'Schmidt'.
	self assert: ((person slotDefinitionNamed: 'lastName') persistedSlotVarIn: person) isNil.
	self currentSystem applyChanges.
	self assert: ((person slotDefinitionNamed: 'lastName') persistedSlotVarIn: person) equals: 'Schmidt'
]
