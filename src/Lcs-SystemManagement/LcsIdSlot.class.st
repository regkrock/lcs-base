Class {
	#name : 'LcsIdSlot',
	#superclass : 'LcsStringSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'initialize' }
LcsIdSlot >> initialize [
	super initialize.
	self slotName: 'id'
]
