Class {
	#name : 'LcsLocalCollectionSlotBuilderTest',
	#superclass : 'LcsCodeBuilderStepTest',
	#category : 'Lcs-SlotToolsTests-Tests',
	#package : 'Lcs-SlotToolsTests',
	#tag : 'Tests'
}

{ #category : 'tests' }
LcsLocalCollectionSlotBuilderTest >> testCreation [
	self assert: LcsLocalCollectionSlotBuilder slotClass equals: LcsLocalCollectionSlot.
	"self error: 'Needs more work'"
]
