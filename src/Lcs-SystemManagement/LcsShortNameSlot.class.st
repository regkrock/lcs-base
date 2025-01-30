Class {
	#name : #LcsShortNameSlot,
	#superclass : #LcsStringSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #initialize }
LcsShortNameSlot >> initialize [
	super initialize.
	self 
		slotName: 'shortName'
]
