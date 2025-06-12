Class {
	#name : #LcsLocalCollectionSlotDefinitionBuilderTest,
	#superclass : #LcsCodeBuilderStepTest,
	#category : #'Lcs-SlotToolsTests-Tests'
}

{ #category : #tests }
LcsLocalCollectionSlotDefinitionBuilderTest >> testCreation [
	self assert: LcsLocalCollectionSlotBuilder slotDefinitionClass equals: LcsLocalCollectionSlot.
	"self error: 'Needs more work'"
]
