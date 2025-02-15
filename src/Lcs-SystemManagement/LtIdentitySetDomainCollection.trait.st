Trait {
	#name : #LtIdentitySetDomainCollection,
	#traits : 'LtDomainCollection',
	#classTraits : 'LtDomainCollection classTrait',
	#category : #'Lcs-SystemManagement-Traits'
}

{ #category : #'as yet unclassified' }
LtIdentitySetDomainCollection classSide >> collectionSlotDefinition [
	<slotDefinition>
	^ LcsIdentitySetSlot new
]
