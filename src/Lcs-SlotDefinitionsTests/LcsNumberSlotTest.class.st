Class {
	#name : #LcsNumberSlotTest,
	#superclass : #LcsPrototypeSystemRunningTestCase,
	#category : #'Lcs-SlotDefinitionsTests-Tests'
}

{ #category : #tests }
LcsNumberSlotTest >> testInitialValue [
	self subject: (LxxPerson slotModel slotDefinitionNamed: 'weight').
	self assert: (self subject isKindOf: LcsNumberSlot).
	self assert: self subject initialValue equals: 0.

	self subject initialValue: 100.
	self assert: self subject initialValueBlock printString equals: '[ :domainObject :slot | 100 ]'
]

{ #category : #tests }
LcsNumberSlotTest >> testInstallation [
	subject := LxxPerson slotModel slotDefinitionNamed: 'weight'.
	self assert: subject slotName equals: 'weight'.
	self assert: subject class == LcsNumberSlot
]

{ #category : #tests }
LcsNumberSlotTest >> testSlotGetter [
	| person |
	person := LxxPerson new.
	self assert: person weight isZero.
]

{ #category : #tests }
LcsNumberSlotTest >> testSlotSetter [
	| person |
	person := LxxPerson new.
	self assert: person weight isZero.
	person weight: 100.5.
	self assert: person isInAddingState.
	self assert: person weight equals: 100.5.
	"This may be wrong. Should it return nil as we are in add state"
	self assert: ((person slotDefinitionNamed: 'weight') persistedSlotVarIn: person) equals: 100.5
]
