Class {
	#name : #LcsShortNameSlot,
	#superclass : #LcsStringSlot,
	#category : #'Lcs-SlotDefinitions-Core'
}

{ #category : #initialize }
LcsShortNameSlot >> initialize [
	super initialize.
	self 
		slotName: 'shortName'
]
