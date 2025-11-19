Class {
	#name : 'LcsCollectionSlot',
	#superclass : 'LcsSmalltalkObjectSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'defaults' }
LcsCollectionSlot >> defaultInitialValueBlock [
	^ [ :parentDomainObject :slot | self typeClass new ]
]

{ #category : 'initialize' }
LcsCollectionSlot >> initialize [
	super initialize.
	self slotName: 'collection'
]
