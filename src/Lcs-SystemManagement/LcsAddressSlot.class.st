Class {
	#name : 'LcsAddressSlot',
	#superclass : 'LcsDomainObjectSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'initialize' }
LcsAddressSlot >> initialize [
	super initialize.
	self slotName: 'address'.
	self addSlotType: LcsAddress

]
