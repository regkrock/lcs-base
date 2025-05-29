Class {
	#name : #LcsLocalCollectionReferenceSlotBuilderTest,
	#superclass : #LcsCodeBuilderStepTest,
	#category : #'Lcs-SlotToolsTests-Tests'
}

{ #category : #tests }
LcsLocalCollectionReferenceSlotBuilderTest >> testCreation [
	<TODO: 'need to add test for creation of slot definition method'>
	self assert: LcsLocalCollectionReferenceSlotBuilder slotDefinitionClass equals: LcsLocalCollectionReferenceSlot.
]
