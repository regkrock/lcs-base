Class {
	#name : #LcsObjectVersionSlotTest,
	#superclass : #LcsTestCase,
	#category : #'Lcs-SlotDefinitionsTests'
}

{ #category : #tests }
LcsObjectVersionSlotTest >> testCreation [
	subject := LcsObjectVersionSlot new.
	self assert: (subject isKindOf: LcsObjectVersionSlot).
	self assert: subject slotName equals: 'version'.
	self assert: (subject slotTypes includes: SmallInteger).
	self deny: (subject slotTypes includes: UndefinedObject).
	self assert: subject initialValueBlockSourceCode equals: '[ anObject ]'.
	self assert: subject initialValue equals: 0.

]
