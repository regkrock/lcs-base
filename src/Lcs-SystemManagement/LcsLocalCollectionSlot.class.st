Class {
	#name : 'LcsLocalCollectionSlot',
	#superclass : 'LcsPrimaryCollectionSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'testing' }
LcsLocalCollectionSlot >> isLocalCollectionSlot [
	^ true
]

{ #category : 'testing' }
LcsLocalCollectionSlot >> slotVarPut: anObject in: aDomainObject [
	super slotVarPut: anObject in: aDomainObject.
	self currentUnitOfWork changedCollections 
]
