Class {
	#name : #LcsLocalCollectionSlotBuilderTest,
	#superclass : #LcsCodeBuilderStepTest,
	#category : #'Lcs-SlotToolsTests-Tests'
}

{ #category : #tests }
LcsLocalCollectionSlotBuilderTest >> testCreation [
	self assert: LcsLocalCollectionSlotBuilder slotDefinitionClass equals: LcsLocalCollectionSlot.
	"self error: 'Needs more work'"
]
