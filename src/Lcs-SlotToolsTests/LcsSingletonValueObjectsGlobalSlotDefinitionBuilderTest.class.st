Class {
	#name : #LcsSingletonValueObjectsGlobalSlotDefinitionBuilderTest,
	#superclass : #LcsCodeBuilderStepTest,
	#category : #'Lcs-SlotToolsTests-Tests'
}

{ #category : #tests }
LcsSingletonValueObjectsGlobalSlotDefinitionBuilderTest >> testCreation [
	<TODO: 'need to add test for creation of slot definition method'>
	self assert: LcsSingletonValueObjectsGlobalSlotDefinitionBuilder slotDefinitionClass equals: LcsSingletonValueObjectsGlobalCollectionSlot.
]
