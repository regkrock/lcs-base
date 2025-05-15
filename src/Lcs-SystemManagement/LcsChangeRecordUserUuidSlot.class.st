Class {
	#name : #LcsChangeRecordUserUuidSlot,
	#superclass : #LcsIntegerSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #initialize }
LcsChangeRecordUserUuidSlot >> initialize [
	super initialize.
	self 
		slotName: 'userUuid';
		beRequired;
		makeDirectUpdateOfVariable
]
