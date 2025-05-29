Class {
	#name : #LcsBooleanSlotDefinitionBuilderTest,
	#superclass : #LcsCodeBuilderStepTest,
	#category : #'Lcs-SlotToolsTests-Tests'
}

{ #category : #tests }
LcsBooleanSlotDefinitionBuilderTest >> testCreation [
	self assert: LcsBooleanSlotDefinitionBuilder slotDefinitionClass equals: LcsBooleanSlot
]
