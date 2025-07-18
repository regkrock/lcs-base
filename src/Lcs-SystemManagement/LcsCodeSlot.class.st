Class {
	#name : #LcsCodeSlot,
	#superclass : #LcsStringSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #initialize }
LcsCodeSlot >> initialize [
	super initialize.
	self slotName: 'code'.
	self addSlotType: Integer.
	self addSlotType: ScaledDecimal.
	self addSlotType: Object.
]
