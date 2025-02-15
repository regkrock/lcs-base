Trait {
	#name : #LtDictionaryDomainCollection,
	#traits : 'LtDomainCollection',
	#classTraits : 'LtDomainCollection classTrait',
	#category : #'Lcs-SystemManagement-Traits'
}

{ #category : #'slot definition\t' }
LtDictionaryDomainCollection classSide >> collectionSlotDefinition [
	<slotDefinition>
	^ LcsDictionarySlot new
]
