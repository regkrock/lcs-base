Trait {
	#name : #LtOrderedCollectionDomainCollection,
	#traits : 'LtDomainCollection',
	#classTraits : 'LtDomainCollection classTrait',
	#category : #'Lcs-SystemManagement-Traits'
}

{ #category : #'slot definition' }
LtOrderedCollectionDomainCollection classSide >> collectionSlotDefinition [
	<slotDefinition>
	^ LcsOrderedCollectionSlot new
]
