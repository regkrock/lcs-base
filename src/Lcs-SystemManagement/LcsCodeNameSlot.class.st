Class {
	#name : #LcsCodeNameSlot,
	#superclass : #LcsStringSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #initialize }
LcsCodeNameSlot >> initialize [
	super initialize.
	self 
		slotName: 'codeName'
]
