Class {
	#name : 'LcsDateAndTimeSlot',
	#superclass : 'LcsBaseSmalltalkObjectSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'defaults' }
LcsDateAndTimeSlot >> defaultInitialValueBlock [
	^ [ :parentDomainObject :slot | self typeClass now ]
]

{ #category : 'defaults' }
LcsDateAndTimeSlot >> initialize [
	super initialize.
	self slotName: 'dateAndTime'
]

{ #category : 'defaults' }
LcsDateAndTimeSlot >> typeClass [
	^ DateAndTime 
]
