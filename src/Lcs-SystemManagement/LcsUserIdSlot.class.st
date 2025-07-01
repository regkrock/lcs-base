Class {
	#name : #LcsUserIdSlot,
	#superclass : #LcsStringSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #initialize }
LcsUserIdSlot >> initialize [
	super initialize.
	self slotName: 'userId'
]
