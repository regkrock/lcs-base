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

{ #category : #initialize }
LcsGlobalCollections >> initialize [
	super initialize.
	"self collection: LcsSmalltalkConfiguration stringDictionaryClass new"
]
