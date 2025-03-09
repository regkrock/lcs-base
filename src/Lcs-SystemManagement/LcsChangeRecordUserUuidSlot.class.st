Class {
	#name : #LcsChangeRecordUserUuidSlot,
	#superclass : #LcsIntegerSlot,
	#traits : 'LtDirectSlotAccess',
	#classTraits : 'LtDirectSlotAccess classTrait',
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #initialize }
LcsChangeRecordUserUuidSlot >> initialize [
	super initialize.
	self 
		slotName: 'userUuid';
		beRequired
]
