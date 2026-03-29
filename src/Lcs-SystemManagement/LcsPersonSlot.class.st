Class {
	#name : 'LcsPersonSlot',
	#superclass : 'LcsDomainObjectSlot',
	#category : 'Lcs-SystemManagement-Slots',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slots'
}

{ #category : 'initialize' }
LcsPersonSlot >> initialize [
	super initialize.
	self slotName: 'person'.
	self addSlotType: LcsPerson.
	self addSlotType: LcsUnknownPerson.
	self beAllowInitialNil.
]
