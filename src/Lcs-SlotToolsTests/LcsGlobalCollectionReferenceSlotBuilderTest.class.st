Class {
	#name : #LcsGlobalCollectionReferenceSlotBuilderTest,
	#superclass : #LcsCodeBuilderStepTest,
	#category : #'Lcs-SlotToolsTests-Tests'
}

{ #category : #tests }
LcsGlobalCollectionReferenceSlotBuilderTest >> testCreation [
	<TODO: 'need to add test for creation of slot definition method'>
	self assert: LcsGlobalCollectionReferenceSlotBuilder slotClass equals: LcsGlobalCollectionReferenceSlot
]
