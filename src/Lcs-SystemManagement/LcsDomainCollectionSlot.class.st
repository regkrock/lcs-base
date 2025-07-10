Class {
	#name : #LcsDomainCollectionSlot,
	#superclass : #LcsDomainObjectSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #'slot definitions' }
LcsDomainCollectionSlot >> addCollectionMemberType: aClass [
	(self collectionMemberTypes includes: aClass)
		ifFalse: [ self collectionMemberTypes add: aClass ]
]

{ #category : #configuration }
LcsDomainCollectionSlot >> beIdentitySetCollection [
	self collectionClass: LcsSmalltalkConfiguration identitySetClass
]

{ #category : #configuration }
LcsDomainCollectionSlot >> beOrderedCollection [
	self collectionClass: OrderedCollection
]

{ #category : #properties }
LcsDomainCollectionSlot >> collectionClass [
	^ self propertyAt: 'collectionClass' ifAbsent: [ ]
]

{ #category : #properties }
LcsDomainCollectionSlot >> collectionClass: anObject [
	self propertyAt: 'collectionClass' put: anObject
]

{ #category : #properties }
LcsDomainCollectionSlot >> collectionMemberTypes [
	^ self propertyAt: 'collectionMemberTypes' ifAbsent: [ ]
]

{ #category : #properties }
LcsDomainCollectionSlot >> collectionMemberTypes: anObject [
	self propertyAt: 'collectionMemberTypes' put: anObject
]

{ #category : #initialize }
LcsDomainCollectionSlot >> initialize [
	super initialize.
	self collectionMemberTypes: OrderedCollection new.
	self beIdentitySetCollection
]

{ #category : #testing }
LcsDomainCollectionSlot >> isGlobalCollectionSlot [
	^ false
]

{ #category : #testing }
LcsDomainCollectionSlot >> isLocalCollectionSlot [
	^ false
]

{ #category : #testing }
LcsDomainCollectionSlot >> isSlotTypeIdentitySet [
	^ self slotTypes size = 1
		and: [ self slotTypes includes: LcsSmalltalkConfiguration identitySetClass ]
]
