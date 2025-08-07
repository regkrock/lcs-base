Class {
	#name : #LcsValueCodeSlot,
	#superclass : #LcsStringSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #initialize }
LcsValueCodeSlot >> initialize [
	super initialize.
	self slotName: 'code'
]
