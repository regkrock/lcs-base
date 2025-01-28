Class {
	#name : #LcsIdSlot,
	#superclass : #LcsStringSlot,
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #'as yet unclassified' }
LcsIdSlot >> initialize [
	super initialize.
	self slotName: 'id'
]
