Class {
	#name : #LcsCodeDescriptionSlot,
	#superclass : #LcsStringSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #initialize }
LcsCodeDescriptionSlot >> initialize [
	super initialize.
	self 
		slotName: 'codeDescription'
]
