Class {
	#name : 'LcsDescriptionSlot',
	#superclass : 'LcsStringSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'initialize' }
LcsDescriptionSlot >> initialize [
	super initialize.
	self slotName: 'description'
]
