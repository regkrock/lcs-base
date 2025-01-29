Class {
	#name : #LcsUserIdSlot,
	#superclass : #LcsStringSlot,
	#category : #'Lcs-SystemManagement'
}

{ #category : #'as yet unclassified' }
LcsUserIdSlot >> initialize [
	super initialize.
	self slotName: 'userId'
]
