Class {
	#name : #LcsChangeRecordUserIdSlot,
	#superclass : #LcsUserIdSlot,
	#traits : 'LtDirectSlotAccess',
	#classTraits : 'LtDirectSlotAccess classTrait',
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #initialize }
LcsChangeRecordUserIdSlot >> initialize [
	super initialize.
	self 
		slotName: 'userId';
		beRequired
]
