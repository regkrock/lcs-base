Class {
	#name : #LcsCodeNameSlot,
	#superclass : #LcsStringSlot,
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #accessing }
LcsCodeNameSlot >> initialize [
	super initialize.
	self slotName: 'codeName'
]
