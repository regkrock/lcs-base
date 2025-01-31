Class {
	#name : #LcsTimestampSlot,
	#superclass : #LcsSmalltalkObjectSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #defaults }
LcsTimestampSlot >> defaultInitialValueBlock [
	^ [ self typeClass now ]
]

{ #category : #defaults }
LcsTimestampSlot >> initialize [
	super initialize.
	self slotName: 'timestamp'
]

{ #category : #default }
LcsTimestampSlot >> typeClass [
	^ DateAndTime 
]
