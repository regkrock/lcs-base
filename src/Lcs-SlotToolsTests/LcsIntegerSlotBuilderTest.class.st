Class {
	#name : #LcsIntegerSlotBuilderTest,
	#superclass : #LcsCodeBuilderStepTest,
	#category : #'Lcs-SlotToolsTests-Tests'
}

{ #category : #tests }
LcsIntegerSlotBuilderTest >> testCreation [
	self assert: LcsIntegerSlotBuilder slotClass equals: LcsIntegerSlot
]
