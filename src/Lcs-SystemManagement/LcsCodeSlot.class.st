Class {
	#name : #LcsCodeSlot,
	#superclass : #LcsStringSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #initialize }
LcsCodeSlot >> initialize [
	super initialize.
	self slotName: 'code'
]
