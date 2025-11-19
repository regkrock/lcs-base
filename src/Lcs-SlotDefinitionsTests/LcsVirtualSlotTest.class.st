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
LcsVirtualSlotTest >> testAccessingUsingValueAccessor [
	| result |
	self subject: LcsVirtualSlotExamples new isInEffectVirtualSlot.
	result := self subject currentSlotVarIn: LcsDateRange new.
	self assert: result
]

{ #category : 'tests' }
LcsVirtualSlotTest >> testAccessingViaVirtualSlot [
	self subject: LcsDateRange new.
	self assert: self subject isInEffect
]

{ #category : 'tests' }
LcsVirtualSlotTest >> testCreation [
	self subject: LcsVirtualSlotExamples new virtualSlot.
	self subject slotName: #test.
	self assert: self subject slotName equals: #test.
	self subject addSlotType: Date.
	self assert: (self subject slotTypes includes: Date)
]

{ #category : 'testing' }
LcsVirtualSlotTest >> testIsVirtualSlot [
	self subject: LcsVirtualSlotExamples new virtualSlot.
	self assert: self subject isVirtualSlot
]

{ #category : 'tests' }
LcsVirtualSlotTest >> testSettingSlot [
	self subject: LcsVirtualSlotExamples new virtualSlot.
	self should: [ self subject slotVarPut: 'anObject' in: LcsDateRange new ] raise: Error
]
