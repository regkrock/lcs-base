Class {
	#name : #LcsChangeRecordTimestampSlot,
	#superclass : #LcsTimestampSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #initialize }
LcsChangeRecordTimestampSlot >> initialize [
	super initialize.
	self makeDirectUpdateOfVariable
]
