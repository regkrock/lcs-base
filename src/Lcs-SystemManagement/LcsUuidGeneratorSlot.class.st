Class {
	#name : #LcsUuidGeneratorSlot,
	#superclass : #LcsSmalltalkObjectSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #defaults }
LcsUuidGeneratorSlot >> defaultInitialValueBlock [
	^ [ self typeClass basicNew initialize ]
]

{ #category : #defaults }
LcsUuidGeneratorSlot >> initialize [
	super initialize.
	self slotName: 'uuidGenerator'
]

{ #category : #initialize }
LcsUuidGeneratorSlot >> typeClass [
	^ UUIDGenerator
]
