Class {
	#name : 'LcsChangeRecordTimestampSlot',
	#superclass : 'LcsDateAndTimeSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'initialize' }
LcsChangeRecordTimestampSlot >> initialize [
	super initialize.
	self makeDirectUpdateOfVariable
]
