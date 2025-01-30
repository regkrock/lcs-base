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
	self assert: (subject slotTypes includes: SmallInteger).
	self assert: (subject slotTypes includes: UndefinedObject).
	self assert: subject initialValueBlockSourceCode equals: '[ anObject ]'.
	self assert: subject initialValue equals: nil.

]
