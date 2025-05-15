Class {
	#name : #LcsTimeSlot,
	#superclass : #LcsSmalltalkObjectSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #defaults }
LcsTimeSlot >> defaultInitialValueBlock [
	^ [ self typeClass now ]
]

{ #category : #defaults }
LcsTimeSlot >> initialize [
	super initialize.
	self slotName: 'timestamp'
]

{ #category : #defaults }
LcsTimeSlot >> typeClass [
	^ Time 
]
