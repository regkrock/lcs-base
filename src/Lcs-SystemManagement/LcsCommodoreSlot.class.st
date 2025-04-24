Class {
	#name : #LcsCommodoreSlot,
	#superclass : #LcsDomainObjectSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #'as yet unclassified' }
LcsCommodoreSlot >> initialize [
	super initialize.
	self slotName: 'commodore'.
	self addSlotType: LcsAddress

]
