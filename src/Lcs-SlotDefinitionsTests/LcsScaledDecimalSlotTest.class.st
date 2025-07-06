Class {
	#name : #LcsScaledDecimalSlotTest,
	#superclass : #LcsWithPrototypeSystemSetUpForTest,
	#category : #'Lcs-SlotDefinitionsTests-Tests'
}

{ #category : #tests }
LcsScaledDecimalSlotTest >> testInitialValue [
	| person |
	self subject: (LxxPerson slotModel slotDefinitionNamed: 'balance').
	self assert: (self subject isKindOf: LcsScaledDecimalSlot).
	self assert: self subject initialValue equals: 0.

	self subject initialValue: 100s2.
	self
		assert: self subject initialValueBlock printString
		equals: '[ :domainObject :slot | 100.00s2 ]'.
	self assert: self subject initialValue equals: 100.00s2.

	person := LxxPerson new.
	self assert: person balance equals: 100.00s2
]

{ #category : #tests }
LcsScaledDecimalSlotTest >> testInstallation [
	subject := LxxPerson slotModel slotDefinitionNamed: 'balance'.
	self assert: subject slotName equals: 'balance'.
	self assert: subject class == LcsScaledDecimalSlot
]

{ #category : #tests }
LcsScaledDecimalSlotTest >> testSlotGetter [
	| person |
	person := LxxPerson new.
	self assert: person balance isZero.
	self assert: person balance equals: 0.00s2
]

{ #category : #tests }
LcsScaledDecimalSlotTest >> testSlotSetter [
	| person |
	person := LxxPerson new.
	self assert: person balance isZero.
	person balance: 20.5.
	self assert: person isInAddingState.
	self assert: person balance equals: 20.5.
	"This may be wrong. Should it return nil as we are in add state"
	self assert: ((person slotDefinitionNamed: 'balance') persistedSlotVarIn: person) equals: 20.5
]
