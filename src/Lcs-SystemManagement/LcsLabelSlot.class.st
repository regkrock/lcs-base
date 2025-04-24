Class {
	#name : #LcsLabelSlot,
	#superclass : #LcsStringSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #initialize }
LcsLabelSlot >> initialize [
	super initialize.
	self 
		slotName: 'label'
]
