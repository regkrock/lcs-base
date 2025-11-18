Class {
	#name : #LcsTimeSlot,
	#superclass : #LcsSmalltalkObjectSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #defaults }
LcsTimeSlot >> defaultInitialValueBlock [
	^ [ :parentDomainObject :slot | slot typeClass now ]
]

{ #category : #initialize }
LcsTimeSlot >> initialize [
	super initialize.
	self slotName: 'timestamp'
]

{ #category : #defaults }
LcsTimeSlot >> typeClass [
	^ Time 
]
