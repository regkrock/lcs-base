Class {
	#name : #LcsUuidSlot,
	#superclass : #LcsSmalltalkObjectSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #initialize }
LcsUuidSlot >> initialize [
	super initialize.
	self slotName: 'uuid'.
	self allowNil
]

{ #category : #configuration }
LcsUuidSlot >> typeClass [
	^ SmallInteger
]
