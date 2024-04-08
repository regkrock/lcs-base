Class {
	#name : #LcsGlobalCollectionSlotDefinition,
	#superclass : #LcsSlotDefinition,
	#instVars : [
		'collectionMemberTypes'
	],
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #'slot definitions' }
LcsGlobalCollectionSlotDefinition >> addCollectionMemberType: aClass [
	(self collectionMemberTypes includes: aClass)
		ifFalse: [ self collectionMemberTypes add: aClass ]
]

{ #category : #configuration }
LcsGlobalCollectionSlotDefinition >> beIdentitySetCollection [
	self slotTypes isEmpty
		ifTrue: [ self addSlotType: LcsSmalltalkConfiguration identitySetClass.
			^ self ].
	self isSlotTypeIdentitySet ifTrue: [ ^ self ].
	self clearSlotTypes.
	self addSlotType: LcsSmalltalkConfiguration identitySetClass
]

{ #category : #accessing }
LcsGlobalCollectionSlotDefinition >> collectionMemberTypes [
	^ collectionMemberTypes
]

{ #category : #accessing }
LcsGlobalCollectionSlotDefinition >> collectionMemberTypes: anObject [
	collectionMemberTypes := anObject
]

{ #category : #initialize }
LcsGlobalCollectionSlotDefinition >> initialize [
	super initialize.
	self collectionMemberTypes: OrderedCollection new
]

{ #category : #'testing ' }
LcsGlobalCollectionSlotDefinition >> isSlotTypeIdentitySet [
	^ self slotTypes size = 1
		ifFalse: [ self slotTypes includes: LcsSmalltalkConfiguration identitySetClass ]
]

{ #category : #model }
LcsGlobalCollectionSlotDefinition >> persistValue: anObject [
	(self getValueIn: self slotName asString) persistValue: anObject
]

{ #category : #model }
LcsGlobalCollectionSlotDefinition >> persistValue: anObject in: aModule [
	(self getValueIn: aModule) add: anObject
]
