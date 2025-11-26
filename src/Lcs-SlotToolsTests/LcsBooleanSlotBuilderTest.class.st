Class {
	#name : 'LcsBooleanSlotBuilderTest',
	#superclass : 'LcsCodeBuilderStepTest',
	#category : 'Lcs-SlotToolsTests-Tests',
	#package : 'Lcs-SlotToolsTests',
	#tag : 'Tests'
}

{ #category : 'tests' }
LcsBooleanSlotBuilderTest >> testCreation [
	self assert: LcsBooleanSlotBuilder slotClass equals: LcsBooleanSlot
]
