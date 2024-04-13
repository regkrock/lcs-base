Class {
	#name : #LcsGlobalCollectionSlot,
	#superclass : #LcsSlotDefintion,
	#instVars : [
		'collectionMemberTypes',
		'collectionSlotClass'
	],
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #'slot definitions' }
LcsGlobalCollectionSlot >> addCollectionMemberType: aClass [
	(self collectionMemberTypes includes: aClass)
		ifFalse: [ self collectionMemberTypes add: aClass ]
]

{ #category : #configuration }
LcsGlobalCollectionSlot >> beIdentitySetCollection [
	self collectionSlotClass: LcsSmalltalkConfiguration identitySetClass
]

{ #category : #configuration }
LcsGlobalCollectionSlot >> beOrderedCollection [
	self collectionSlotClass: OrderedCollection
]

{ #category : #accessing }
LcsGlobalCollectionSlot >> collectionMemberTypes [
	^ collectionMemberTypes
]

{ #category : #accessing }
LcsGlobalCollectionSlot >> collectionMemberTypes: anObject [
	collectionMemberTypes := anObject
]

{ #category : #accessing }
LcsGlobalCollectionSlot >> collectionSlotClass [
	^ collectionSlotClass
]

{ #category : #accessing }
LcsGlobalCollectionSlot >> collectionSlotClass: anObject [
	collectionSlotClass := anObject
]

{ #category : #initialize }
LcsGlobalCollectionSlot >> initialize [
	super initialize.
	self collectionMemberTypes: OrderedCollection new
]

{ #category : #model }
LcsGlobalCollectionSlot >> initializeModel: aDomainObject [
	self
		setValueTo: (self newSlotValue
				parent: aDomainObject;
				yourself)
		in: aDomainObject
]

{ #category : #testing }
LcsGlobalCollectionSlot >> isSlotTypeIdentitySet [
	^ self slotTypes size = 1
		and: [ self slotTypes includes: LcsSmalltalkConfiguration identitySetClass ]
]

{ #category : #accessing }
LcsGlobalCollectionSlot >> newSlotValue [
	^ self slotTypes any newWithCollection: self  collectionSlotClass
]

{ #category : #model }
LcsGlobalCollectionSlot >> persistValue: anObject [
	(self getValueIn: self slotName asString) persistValue: anObject
]

{ #category : #model }
LcsGlobalCollectionSlot >> persistValue: anObject in: aModule [
	(self getValueIn: aModule) add: anObject
]
