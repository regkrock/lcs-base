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
	<slotDefinition>
	^ LcsIdentityDictionarySlot new
]
