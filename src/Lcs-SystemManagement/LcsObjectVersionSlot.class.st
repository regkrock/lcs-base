Class {
	#name : #LcsObjectVersionSlot,
	#superclass : #LcsSmalltalkObjectSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #defaults }
LcsObjectVersionSlot >> defaultInitialValueBlock [
	^ [ :parentDomainObject :slot | 0 ]
]

{ #category : #defaults }
LcsObjectVersionSlot >> initialize [
	super initialize.
	self slotName: 'version'
]

{ #category : #initialize }
LcsObjectVersionSlot >> typeClass [
	^ SmallInteger
]
