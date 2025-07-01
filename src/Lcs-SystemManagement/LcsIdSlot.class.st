Class {
	#name : #LcsIdSlot,
	#superclass : #LcsStringSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #initialize }
LcsIdSlot >> initialize [
	super initialize.
	self slotName: 'id'
]
