Class {
	#name : #LcsContextSlot,
	#superclass : #LcsAcessorSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #initialize }
LcsContextSlot >> initialize [
	super initialize.
	self
		slotName: 'context';
		addSlotType: Object;
		beAllowNil;
		initialValue: nil
]
