Class {
	#name : 'LcsChangeRecordUserUuidSlot',
	#superclass : 'LcsIntegerSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'initialize' }
LcsChangeRecordUserUuidSlot >> initialize [
	super initialize.
	self 
		slotName: 'userUuid';
		beRequired;
		makeDirectUpdateOfVariable
]
