Class {
	#name : #LcsCodeNameSlot,
	#superclass : #LcsStringSlot,
	#category : #'Lcs-SlotDefinitions-Core'
}

{ #category : #initialize }
LcsCodeNameSlot >> initialize [
	super initialize.
	self 
		slotName: 'codeName'
]
