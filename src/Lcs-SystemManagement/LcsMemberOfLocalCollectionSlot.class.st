Class {
	#name : 'LcsMemberOfLocalCollectionSlot',
	#superclass : 'LcsMemberOfCollectionSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'properties' }
LcsMemberOfLocalCollectionSlot >> collectionSlotName [
	^ self propertyAt: 'collectionSlotName' ifAbsent: []
]

{ #category : 'properties' }
LcsMemberOfLocalCollectionSlot >> collectionSlotName: aString [ 
	self propertyAt: 'collectionSlotName' put: aString
]

{ #category : 'defaults' }
LcsMemberOfLocalCollectionSlot >> defaultInitialValueBlock [
	^ [ :parentDomainObject :slot | (slot targetCollectionIn: parentDomainObject) defaultInstance ]
]
