Class {
	#name : #LcsObjectVersionSlot,
	#superclass : #LcsSmalltalkObjectSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #initialize }
LcsObjectVersionSlot >> initialize [
	super initialize.
	self slotName: 'version'.
	self initialValue: 0.
	self addSlotType: SmallInteger
]
