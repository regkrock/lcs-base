Class {
	#name : #LcsScaledDecimalSlotBuilderTest,
	#superclass : #LcsCodeBuilderStepTest,
	#category : #'Lcs-SlotToolsTests-Tests'
}

{ #category : #tests }
LcsScaledDecimalSlotBuilderTest >> testCreation [
	self assert: LcsScaledDecimalSlotBuilder slotClass equals: LcsScaledDecimalSlot
]
