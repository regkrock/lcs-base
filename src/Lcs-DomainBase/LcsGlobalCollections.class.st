Class {
	#name : #LcsGlobalCollections,
	#superclass : #LcsDomainCollection,
	#category : #'Lcs-DomainBase-Core'
}

{ #category : #'slot model' }
LcsGlobalCollections class >> collectionSlotDefinition [
	<slotDefinition>
	^LcsIdentityDictionarySlot new
]
