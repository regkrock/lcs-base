Class {
	#name : 'LcsGlobalCollections',
	#superclass : 'LcsDomainCollection',
	#traits : 'LtIdentityDictionaryDomainCollection',
	#classTraits : 'LtIdentityDictionaryDomainCollection classTrait',
	#category : 'Lcs-DomainBase-Core',
	#package : 'Lcs-DomainBase',
	#tag : 'Core'
}

{ #category : 'slot model' }
LcsGlobalCollections class >> collectionSlotDefinition [
	<accessorSlotDefinition>
	^ LcsIdentityDictionarySlot new
]

{ #category : 'collection' }
LcsGlobalCollections >> add: aClass [
	self halt.
]
