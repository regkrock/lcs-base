Class {
	#name : 'LcsMemberOfCollectionInSiblingSlotObjectSlot',
	#superclass : 'LcsMemberOfCollectionSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'defaults' }
LcsMemberOfCollectionInSiblingSlotObjectSlot >> defaultInitialValueBlock [
	^ [ :parentDomainObject :slot | (slot targetCollectionIn: parentDomainObject) defaultInstance ]
]

{ #category : 'properties' }
LcsMemberOfCollectionInSiblingSlotObjectSlot >> siblingCollectionSlotName [
	^ self propertyAt: 'siblingCollectionSlotName'
]

{ #category : 'properties' }
LcsMemberOfCollectionInSiblingSlotObjectSlot >> siblingCollectionSlotName: aString [ 
	self propertyAt: 'siblingCollectionSlotName' put: aString
]

{ #category : 'properties' }
LcsMemberOfCollectionInSiblingSlotObjectSlot >> siblingSlotName [
	^ self propertyAt: 'siblingSlotName'
]

{ #category : 'properties' }
LcsMemberOfCollectionInSiblingSlotObjectSlot >> siblingSlotName: aString [ 
	self propertyAt: 'siblingSlotName' put: aString
]

{ #category : 'slot model' }
LcsMemberOfCollectionInSiblingSlotObjectSlot >> targetCollectionIn: aDomainObject [
	^ (aDomainObject perform: self siblingSlotName asSymbol) perform: self siblingCollectionSlotName asSymbol
]
