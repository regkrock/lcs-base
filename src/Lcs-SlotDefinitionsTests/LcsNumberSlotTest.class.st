Class {
	#name : #LcsNumberSlotTest,
	#superclass : #LcsWithPrototypeSystemSetUpForTest,
	#category : #'Lcs-SlotDefinitionsTests-Tests'
}

{ #category : #tests }
LcsNumberSlotTest >> testInitialValue [
	self subject: (LxxPerson slotModel slotDefinitionNamed: 'age').
	self assert: (self subject isKindOf: LcsNumberSlot).
	self assert: self subject initialValue equals: 0.

	self subject initialValue: 100.
	self assert: self subject initialValueBlock printString equals: '[ :domainObject :slot | 100 ]'
]

{ #category : #tests }
LcsNumberSlotTest >> testInstallation [
	subject := LxxPerson slotModel slotDefinitionNamed: 'age'.
	self assert: subject slotName equals: 'age'.
	self assert: subject class == LcsNumberSlot
]

{ #category : #tests }
LcsNumberSlotTest >> testSlotGetter [
	| person |
	person := LxxPerson new.
	self assert: person age isZero.
]

{ #category : #tests }
LcsNumberSlotTest >> testSlotSetter [
	| person |
	person := LxxPerson new.
	self assert: person age isZero.
	person age: 20.5.
	self assert: person isInAddingState.
	self assert: person age equals: 20.5.
	"This may be wrong. Should it return nil as we are in add state"
	self assert: ((person slotDefinitionNamed: 'age') persistedSlotVarIn: person) equals: 20.5
]
