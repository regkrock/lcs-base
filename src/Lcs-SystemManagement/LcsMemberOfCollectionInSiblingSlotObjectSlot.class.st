Class {
	#name : #LcsMemberOfCollectionInSiblingSlotObjectSlot,
	#superclass : #LcsMemberOfCollectionSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #defaults }
LcsMemberOfCollectionInSiblingSlotObjectSlot >> defaultInitialValueBlock [
	^ [ :domainObject :slot | (slot targetCollectionIn: domainObject) defaultInstance ]
]

{ #category : #properties }
LcsMemberOfCollectionInSiblingSlotObjectSlot >> siblingCollectionSlotName [
	^ self propertyAt: 'siblingCollectionSlotName'
]

{ #category : #properties }
LcsMemberOfCollectionInSiblingSlotObjectSlot >> siblingCollectionSlotName: aString [ 
	self propertyAt: 'siblingCollectionSlotName' put: aString
]

{ #category : #properties }
LcsMemberOfCollectionInSiblingSlotObjectSlot >> siblingSlotName [
	^ self propertyAt: 'siblingSlotName'
]

{ #category : #properties }
LcsMemberOfCollectionInSiblingSlotObjectSlot >> siblingSlotName: aString [ 
	self propertyAt: 'siblingSlotName' put: aString
]

{ #category : #'slot model' }
LcsMemberOfCollectionInSiblingSlotObjectSlot >> targetCollectionIn: aDomainObject [
	^ (aDomainObject perform: self siblingSlotName asSymbol) perform: self siblingCollectionSlotName asSymbol
]
