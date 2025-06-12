Class {
	#name : #LcsStringSlotDefinitionBuilderTest,
	#superclass : #LcsCodeBuilderStepTest,
	#category : #'Lcs-SlotToolsTests-Tests'
}

{ #category : #tests }
LcsStringSlotDefinitionBuilderTest >> testCreation [
	self assert: LcsStringSlotBuilder slotDefinitionClass equals: LcsStringSlot
]
