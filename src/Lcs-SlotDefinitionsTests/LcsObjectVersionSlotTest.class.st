Class {
	#name : #LcsObjectVersionSlotTest,
	#superclass : #LcsTestCase,
	#category : #'Lcs-SlotDefinitionsTests-Tests'
}

{ #category : #tests }
LcsObjectVersionSlotTest >> testCreation [
	subject := LcsObjectVersionSlot new.
	self assert: (subject isKindOf: LcsObjectVersionSlot).
	self assert: subject slotName equals: 'version'.
	self assert: (subject slotTypes includes: SmallInteger).
	self deny: (subject slotTypes includes: UndefinedObject).
	self assert: subject initialValueBlockSourceCode equals: '^ [ 0 ]'.
	self assert: subject initialValue equals: 0.

]
