Class {
	#name : #LcsTimestampSlot,
	#superclass : #LcsSmalltalkObjectSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #defaults }
LcsTimestampSlot >> defaultInitialValueBlock [
	^ [ :domainObject :slot | self typeClass now ]
]

{ #category : #defaults }
LcsTimestampSlot >> initialize [
	super initialize.
	self slotName: 'timestamp'
]

{ #category : #defaults }
LcsTimestampSlot >> typeClass [
	^ DateAndTime 
]
