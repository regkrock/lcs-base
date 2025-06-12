Class {
	#name : #LcsIntegerSlotDefinitionBuilderTest,
	#superclass : #LcsCodeBuilderStepTest,
	#category : #'Lcs-SlotToolsTests-Tests'
}

{ #category : #tests }
LcsIntegerSlotDefinitionBuilderTest >> testCreation [
	self assert: LcsIntegerSlotBuilder slotDefinitionClass equals: LcsIntegerSlot
]
