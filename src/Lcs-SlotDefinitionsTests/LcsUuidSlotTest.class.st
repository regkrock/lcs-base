Class {
	#name : #LcsUuidSlotTest,
	#superclass : #LcsTestCase,
	#category : #'Lcs-SlotDefinitionsTests-Tests'
}

{ #category : #tests }
LcsUuidSlotTest >> testCreation [
	subject := LcsUuidSlot new.
	self assert: (subject isKindOf: LcsUuidSlot).
	self assert: subject slotName equals: 'uuid'.
	self assert: (subject slotTypes includes: Integer).
	self assert: subject initialValueBlock asString equals: '[ :domainObject :slot | domainObject currentSystem uuidGenerator next asInteger  ]'

]
