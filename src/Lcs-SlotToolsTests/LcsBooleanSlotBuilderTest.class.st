Class {
	#name : #LcsBooleanSlotBuilderTest,
	#superclass : #LcsCodeBuilderStepTest,
	#category : #'Lcs-SlotToolsTests-Tests'
}

{ #category : #tests }
LcsBooleanSlotBuilderTest >> testCreation [
	self assert: LcsBooleanSlotBuilder slotClass equals: LcsBooleanSlot
]
