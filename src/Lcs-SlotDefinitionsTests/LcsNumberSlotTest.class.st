Class {
	#name : 'LcsNumberSlotTest',
	#superclass : 'LcsPrototypeSystemRunningTest',
	#category : 'Lcs-SlotDefinitionsTests-Tests',
	#package : 'Lcs-SlotDefinitionsTests',
	#tag : 'Tests'
}

{ #category : 'tests' }
LcsNumberSlotTest >> testInitialValue [
	self subject: (LxxPerson slotModel slotDefinitionNamed: 'weight').
	self assert: (self subject isKindOf: LcsNumberSlot).
	self assert: self subject initialValue equals: 0.

	self subject initialValue: 100.
	self assert: self subject initialValueBlock printString equals: '[ :parentDomainObject :slot | 100 ]'
]

{ #category : 'tests' }
LcsNumberSlotTest >> testInstallation [
	subject := LxxPerson slotModel slotDefinitionNamed: 'weight'.
	self assert: subject slotName equals: 'weight'.
	self assert: subject class == LcsNumberSlot
]

{ #category : 'tests' }
LcsNumberSlotTest >> testSlotGetter [
	| person |
	person := LxxPerson new.
	self assert: person weight isZero.
]

{ #category : 'tests' }
LcsNumberSlotTest >> testSlotSetter [
	| person |
	person := LxxPerson new.
	self assert: person weight isZero.
	person weight: 100.5.
	self assert: person isInAddingState.
	self assert: person weight equals: 100.5.
	self assert: ((person slotDefinitionNamed: 'weight') persistedSlotVarIn: person) isNil.
	self currentSystem applyChanges.
	self assert: ((person slotDefinitionNamed: 'weight') persistedSlotVarIn: person) equals: 100.5
]
