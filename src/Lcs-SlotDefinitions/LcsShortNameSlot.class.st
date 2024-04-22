Class {
	#name : #LcsShortNameSlot,
	#superclass : #LcsStringSlot,
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #accessing }
LcsShortNameSlot >> initialize [
	super initialize.
	self slotName: 'shortName'
]
