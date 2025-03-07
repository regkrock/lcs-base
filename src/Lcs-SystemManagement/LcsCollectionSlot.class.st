Class {
	#name : #LcsCollectionSlot,
	#superclass : #LcsSmalltalkObjectSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #defaults }
LcsCollectionSlot >> defaultInitialValueBlock [
	^ [ self typeClass new ]
]

{ #category : #initialize }
LcsCollectionSlot >> initialize [
	super initialize.
	self slotName: 'collection'
]
