Class {
	#name : 'LcsChangeRecordTimestampSlot',
	#superclass : 'LcsTimestampSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'initialize' }
LcsChangeRecordTimestampSlot >> initialize [
	super initialize.
	self makeDirectUpdateOfVariable
]
