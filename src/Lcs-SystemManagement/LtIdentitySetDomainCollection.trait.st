Trait {
	#name : #LtIdentitySetDomainCollection,
	#traits : 'LtDomainCollection',
	#classTraits : 'LtDomainCollection classTrait',
	#category : #'Lcs-SystemManagement-Traits'
}

{ #category : #configuration }
LtIdentitySetDomainCollection classSide >> collectionSlotDefinition [
	<slotDefinition>
	^ LcsIdentitySetSlot new
]
