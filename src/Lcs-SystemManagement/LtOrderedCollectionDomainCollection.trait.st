Trait {
	#name : 'LtOrderedCollectionDomainCollection',
	#traits : 'LtDomainCollection',
	#classTraits : 'LtDomainCollection classTrait',
	#category : 'Lcs-SystemManagement-Traits',
	#package : 'Lcs-SystemManagement',
	#tag : 'Traits'
}

{ #category : 'slot definition' }
LtOrderedCollectionDomainCollection classSide >> collectionSlotDefinition [
	<slotDefinition>
	^ LcsOrderedCollectionSlot new
]
