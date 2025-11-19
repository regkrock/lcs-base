Class {
	#name : 'LcsContextSlot',
	#superclass : 'LcsAccessorSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'initialize' }
LcsContextSlot >> initialize [
	super initialize.
	self
		slotName: 'context';
		addSlotType: Object;
		beAllowNil;
		initialValue: nil
]
