Class {
	#name : #LcsDomainCollectionSlot,
	#superclass : #LcsDomainObjectSlot,
	#instVars : [
		'collectionMemberTypes',
		'collectionClass'
	],
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

{ #category : #accessing }
LcsDomainCollectionSlot >> collectionClass [
	^ collectionClass
]

{ #category : #accessing }
LcsDomainCollectionSlot >> collectionClass: anObject [
	collectionClass := anObject
]

{ #category : #accessing }
LcsDomainCollectionSlot >> collectionMemberTypes [
	^ collectionMemberTypes
]

{ #category : #accessing }
LcsDomainCollectionSlot >> collectionMemberTypes: anObject [
	collectionMemberTypes := anObject
]

{ #category : #initialize }
LcsDomainCollectionSlot >> initialize [
	super initialize.
	self collectionMemberTypes: OrderedCollection new
]

{ #category : #accessing }
LcsDomainCollectionSlot >> isGlobalCollectionSlot [
	^ false
]

{ #category : #accessing }
LcsDomainCollectionSlot >> isLocalCollectionSlot [
	^ false
]

{ #category : #testing }
LcsDomainCollectionSlot >> isSlotTypeIdentitySet [
	^ self slotTypes size = 1
		and: [ self slotTypes includes: LcsSmalltalkConfiguration identitySetClass ]
]
