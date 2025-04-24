Class {
	#name : #LcsAddressSlot,
	#superclass : #LcsDomainObjectSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #'as yet unclassified' }
LcsAddressSlot >> initialize [
	super initialize.
	self slotName: 'address'.
	self addSlotType: LcsAddress

]
