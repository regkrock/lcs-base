Class {
	#name : #LcsCollectionSlot,
	#superclass : #LcsSmalltalkObjectSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #default }
LcsCollectionSlot >> defaultInitialValueBlaock [
	^ [ self typeClass new ]
]

{ #category : #iniitialize }
LcsCollectionSlot >> initialize [
	super initialize.
	self slotName: 'collection'
]
