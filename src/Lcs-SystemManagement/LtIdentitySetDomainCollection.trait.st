Trait {
	#name : 'LtIdentitySetDomainCollection',
	#traits : 'LtDomainCollection',
	#classTraits : 'LtDomainCollection classTrait',
	#category : 'Lcs-SystemManagement-Traits',
	#package : 'Lcs-SystemManagement',
	#tag : 'Traits'
}

{ #category : 'configuration' }
LtIdentitySetDomainCollection classSide >> collectionSlotDefinition [
	<accessorSlotDefinition>
	^ LcsIdentitySetSlot new
]
