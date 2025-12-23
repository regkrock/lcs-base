Trait {
	#name : 'LtIdentityDictionaryDomainCollection',
	#instVars : [
		'collection'
	],
	#traits : 'LtDictionaryDomainCollection',
	#classTraits : 'LtDictionaryDomainCollection classTrait',
	#category : 'Lcs-SystemManagement-Traits',
	#package : 'Lcs-SystemManagement',
	#tag : 'Traits'
}

{ #category : 'slot definition\t' }
LtIdentityDictionaryDomainCollection classSide >> collectionSlotDefinition [
	<accessorSlotDefinition>
	^ LcsIdentityDictionarySlot new
]
