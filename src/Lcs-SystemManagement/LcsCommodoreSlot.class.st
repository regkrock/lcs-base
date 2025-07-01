Class {
	#name : #LcsCommodoreSlot,
	#superclass : #LcsDomainObjectSlot,
	#traits : 'LtAggregateAssociation',
	#classTraits : 'LtAggregateAssociation classTrait',
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #initialize }
LcsCommodoreSlot >> initialize [
	super initialize.
	self slotName: 'commodore'.
	self addSlotType: LcsPerson

]
