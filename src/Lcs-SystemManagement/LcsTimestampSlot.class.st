Class {
	#name : 'LcsTimestampSlot',
	#superclass : 'LcsSmalltalkObjectSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'defaults' }
LcsTimestampSlot >> defaultInitialValueBlock [
	^ [ :parentDomainObject :slot | self typeClass now ]
]

{ #category : 'defaults' }
LcsTimestampSlot >> initialize [
	super initialize.
	self slotName: 'timestamp'
]

{ #category : 'defaults' }
LcsTimestampSlot >> typeClass [
	^ DateAndTime 
]
