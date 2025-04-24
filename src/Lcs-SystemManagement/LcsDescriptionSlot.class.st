Class {
	#name : #LcsDescriptionSlot,
	#superclass : #LcsStringSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #initialize }
LcsDescriptionSlot >> initialize [
	super initialize.
	self 
		slotName: 'description'
]
