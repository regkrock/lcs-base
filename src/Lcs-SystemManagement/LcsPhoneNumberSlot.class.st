Class {
	#name : #LcsPhoneNumberSlot,
	#superclass : #LcsStringSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #initialize }
LcsPhoneNumberSlot >> initialize [
	super initialize.
	self slotName: 'number'
]
