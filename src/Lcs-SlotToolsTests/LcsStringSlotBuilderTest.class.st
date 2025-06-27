Class {
	#name : #LcsStringSlotBuilderTest,
	#superclass : #LcsCodeBuilderStepTest,
	#category : #'Lcs-SlotToolsTests-Tests'
}

{ #category : #tests }
LcsStringSlotBuilderTest >> testCreation [
	self assert: LcsStringSlotBuilder slotClass equals: LcsStringSlot
]
