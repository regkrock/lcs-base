Class {
	#name : 'LcsLocalCollectionSlot',
	#superclass : 'LcsDomainCollectionSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'slot model' }
LcsLocalCollectionSlot >> add: anObject to: aDomainObject [
	(aDomainObject perform: self slotName asSymbol) add: anObject.
	self postAddActions execute: anObject context: aDomainObject oldValue: nil
]

{ #category : 'testing' }
LcsLocalCollectionSlot >> isLocalCollectionSlot [
	^ true
]

{ #category : 'testing' }
LcsLocalCollectionSlot >> slotVarPut: anObject in: aDomainObject [
	super slotVarPut: anObject in: aDomainObject.
	self currentUnitOfWork changedCollections 
]
