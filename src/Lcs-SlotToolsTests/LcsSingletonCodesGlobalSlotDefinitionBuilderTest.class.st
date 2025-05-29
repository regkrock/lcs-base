Class {
	#name : #LcsSingletonCodesGlobalSlotDefinitionBuilderTest,
	#superclass : #LcsCodeBuilderStepTest,
	#category : #'Lcs-SlotToolsTests-Tests'
}

{ #category : #tests }
LcsSingletonCodesGlobalSlotDefinitionBuilderTest >> testCreation [
	<TODO: 'need to add test for creation of slot definition method'>
	self assert: LcsSingletonCodesGlobalSlotDefinitionBuilder slotDefinitionClass equals: LcsSingletonCodesGlobalCollectionSlot.
]
