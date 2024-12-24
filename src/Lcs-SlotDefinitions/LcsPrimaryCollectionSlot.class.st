Class {
	#name : #LcsPrimaryCollectionSlot,
	#superclass : #LcsSlotDefinition,
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #initialize }
LcsPrimaryCollectionSlot >> collectionMemberTypes: anObject [ 
]

{ #category : #initialize }
LcsPrimaryCollectionSlot >> initialize [
	super initialize.
	self collectionMemberTypes: OrderedCollection new
]

{ #category : #testing }
LcsPrimaryCollectionSlot >> isSlotTypeIdentitySet [
	^ self slotTypes size = 1
		and: [ self slotTypes includes: LcsSmalltalkConfiguration identitySetClass ]
]
