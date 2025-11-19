Class {
	#name : 'LcsValueCodeSlot',
	#superclass : 'LcsStringSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'initialize' }
LcsValueCodeSlot >> initialize [
	super initialize.
	self slotName: 'code'
]
