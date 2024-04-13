Class {
	#name : #LcsSecondaryCollectionSlot,
	#superclass : #LcsSlotDefintion,
	#instVars : [
		'collectionMemberTypes',
		'collectionSlotClass'
	],
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #'slot definitions' }
LcsSecondaryCollectionSlot >> addCollectionMemberType: aClass [
	(self collectionMemberTypes includes: aClass)
		ifFalse: [ self collectionMemberTypes add: aClass ]
]

{ #category : #configuration }
LcsSecondaryCollectionSlot >> beIdentitySetCollection [
	self collectionSlotClass: LcsSmalltalkConfiguration identitySetClass
]

{ #category : #configuration }
LcsSecondaryCollectionSlot >> beOrderedCollection [
	self collectionSlotClass: OrderedCollection
]

{ #category : #accessing }
LcsSecondaryCollectionSlot >> collectionMemberTypes [
	^ collectionMemberTypes
]

{ #category : #accessing }
LcsSecondaryCollectionSlot >> collectionMemberTypes: anObject [
	collectionMemberTypes := anObject
]

{ #category : #accessing }
LcsSecondaryCollectionSlot >> collectionSlotClass [
	^ collectionSlotClass
]

{ #category : #accessing }
LcsSecondaryCollectionSlot >> collectionSlotClass: anObject [
	collectionSlotClass := anObject
]

{ #category : #initialize }
LcsSecondaryCollectionSlot >> initialize [
	super initialize.
	self collectionMemberTypes: OrderedCollection new
]

{ #category : #model }
LcsSecondaryCollectionSlot >> initializeModel: aDomainObject [
	self
		setValueTo: (self newSlotValue
				parent: aDomainObject;
				yourself)
		in: aDomainObject
]

{ #category : #testing }
LcsSecondaryCollectionSlot >> isSlotTypeIdentitySet [
	^ self slotTypes size = 1
		and: [ self slotTypes includes: LcsSmalltalkConfiguration identitySetClass ]
]

{ #category : #accessing }
LcsSecondaryCollectionSlot >> newSlotValue [
	^ self slotTypes any newWithCollection: self  collectionSlotClass
]

{ #category : #model }
LcsSecondaryCollectionSlot >> persistValue: anObject [
	(self getValueIn: self slotName asString) persistValue: anObject
]

{ #category : #model }
LcsSecondaryCollectionSlot >> persistValue: anObject in: aModule [
	(self getValueIn: aModule) add: anObject
]
