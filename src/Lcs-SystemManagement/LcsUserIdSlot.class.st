Class {
	#name : 'LcsUserIdSlot',
	#superclass : 'LcsStringSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'initialize' }
LcsUserIdSlot >> initialize [
	super initialize.
	self slotName: 'userId'
]
