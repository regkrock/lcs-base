Class {
	#name : #LcsGlobalCollections,
	#superclass : #LcsDomainCollection,
	#category : #'Lcs-DomainBase'
}

{ #category : #'slot model' }
LcsGlobalCollections class >> collectionSlotDefinition [
	<slotDefinition>
	^LcsIdentityDictionarySlot new
]
