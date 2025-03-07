Class {
	#name : #LcsChangeRecordUserUuidSlot,
	#superclass : #LcsUserIdSlot,
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
