Class {
	#name : 'LcsDateRangeTest',
	#superclass : 'LcsPrototypeSystemRunningTest',
	#category : 'Lcs-PrototypeSystemTests-Tests',
	#package : 'Lcs-PrototypeSystemTests',
	#tag : 'Tests'
}

{ #category : 'tests' }
LcsDateRangeTest >> testAccessingUsingValueAccessor [
	| result |
	self subject: LcsVirtualSlotExamples new isInEffectVirtualSlot.
	result := self subject currentSlotVarIn: LcsDateRange new.
	self assert: result
]

{ #category : 'tests' }
LcsDateRangeTest >> testAccessingViaVirtualSlot [
	self subject: LcsDateRange new.
	self assert: self subject isInEffect
]
