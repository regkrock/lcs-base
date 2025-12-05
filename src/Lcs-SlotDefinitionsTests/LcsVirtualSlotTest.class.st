Class {
	#name : 'LcsVirtualSlotTest',
	#superclass : 'LcsTestCase',
	#category : 'Lcs-SlotDefinitionsTests-Tests',
	#package : 'Lcs-SlotDefinitionsTests',
	#tag : 'Tests'
}

{ #category : 'tests' }
LcsVirtualSlotTest >> testAccessingInstanceVariable [
	self subject: LcsVirtualSlotExamples new virtualSlot.
	self should: [ self subject slotVarNamed: 'anObject' in: LcsDateRange new ] raise: Error
]

{ #category : 'tests' }
LcsVirtualSlotTest >> testAccessingUsingInvalidValueAccessor [
	self subject: LcsVirtualSlotExamples new isInEffectVirtualSlot.
	self subject valueAccessor: #dummy.
	self should: [ self subject currentSlotVarIn: LcsDateRange new] raise: Error
]

{ #category : 'tests' }
LcsVirtualSlotTest >> testCreation [
	self subject: LcsVirtualSlotExamples new virtualSlot.
	self subject slotName: #test.
	self assert: self subject slotName equals: #test.
	self subject addSlotType: Date.
	self assert: (self subject slotTypes includes: Date)
]

{ #category : 'tests' }
LcsVirtualSlotTest >> testIsVirtualSlot [
	self subject: LcsVirtualSlotExamples new virtualSlot.
	self assert: self subject isVirtualSlot
]

{ #category : 'tests' }
LcsVirtualSlotTest >> testSettingSlot [
	self subject: LcsVirtualSlotExamples new virtualSlot.
	self should: [ self subject slotVarPut: 'anObject' in: LcsDateRange new ] raise: Error
]
