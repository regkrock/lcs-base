Class {
	#name : #LcsGlobalCollectionSlot,
	#superclass : #LcsSlotDefintion,
	#instVars : [
		'collectionMemberTypes'
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
	self slotTypes isEmpty
		ifTrue: [ self addSlotType: LcsSmalltalkConfiguration identitySetClass.
			^ self ].
	self isSlotTypeIdentitySet ifTrue: [ ^ self ].
	self clearSlotTypes.
	self addSlotType: LcsSmalltalkConfiguration identitySetClass
]

{ #category : #accessing }
LcsGlobalCollectionSlot >> collectionMemberTypes [
	^ collectionMemberTypes
]

{ #category : #accessing }
LcsGlobalCollectionSlot >> collectionMemberTypes: anObject [
	collectionMemberTypes := anObject
]

{ #category : #initialize }
LcsGlobalCollectionSlot >> initialize [
	super initialize.
	self collectionMemberTypes: OrderedCollection new
]

{ #category : #'testing ' }
LcsGlobalCollectionSlot >> isSlotTypeIdentitySet [
	^ self slotTypes size = 1
		and: [ self slotTypes includes: LcsSmalltalkConfiguration identitySetClass ]
]

{ #category : #model }
LcsGlobalCollectionSlot >> persistValue: anObject [
	(self getValueIn: self slotName asString) persistValue: anObject
]

{ #category : #model }
LcsGlobalCollectionSlot >> persistValue: anObject in: aModule [
	(self getValueIn: aModule) add: anObject
]
