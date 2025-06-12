Class {
	#name : #LcsScaledDecimalSlotDefinitionBuilderTest,
	#superclass : #LcsCodeBuilderStepTest,
	#category : #'Lcs-SlotToolsTests-Tests'
}

{ #category : #tests }
LcsScaledDecimalSlotDefinitionBuilderTest >> testCreation [
	self assert: LcsScaledDecimalSlotBuilder slotDefinitionClass equals: LcsScaledDecimalSlot
]
