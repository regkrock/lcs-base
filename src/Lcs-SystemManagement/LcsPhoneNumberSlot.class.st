Class {
	#name : 'LcsPhoneNumberSlot',
	#superclass : 'LcsStringSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'initialize' }
LcsPhoneNumberSlot >> initialize [
	super initialize.
	self slotName: 'number'
]
