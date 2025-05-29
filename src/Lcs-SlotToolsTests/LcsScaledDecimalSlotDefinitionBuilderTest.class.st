Class {
	#name : #LcsScaledDecimalSlotDefinitionBuilderTest,
	#superclass : #LcsCodeBuilderStepTest,
	#category : #'Lcs-SlotToolsTests-Tests'
}

{ #category : #tests }
LcsScaledDecimalSlotDefinitionBuilderTest >> testCreation [
	self assert: LcsScaledDecimalSlotDefinitionBuilder slotDefinitionClass equals: LcsScaledDecimalSlot
]
