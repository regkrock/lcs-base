Class {
	#name : #LcsIdSlot,
	#superclass : #LcsStringSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #'as yet unclassified' }
LcsIdSlot >> initialize [
	super initialize.
	self slotName: 'id'
]
