Class {
	#name : #LcsGlobalCollections,
	#superclass : #LcsDomainCollection,
	#traits : 'LtIdentityDictionaryDomainCollection',
	#classTraits : 'LtIdentityDictionaryDomainCollection classTrait',
	#category : #'Lcs-DomainBase-Core'
}

{ #category : #'slot model' }
LcsGlobalCollections class >> collectionSlotDefinition [
	<slotDefinition>
	^LcsIdentityDictionarySlot new
]

{ #category : #collection }
LcsGlobalCollections >> add: aClass [
	self halt.
]
