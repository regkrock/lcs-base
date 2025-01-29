Class {
	#name : #LcsUuidSlot,
	#superclass : #LcsSlotDefinition,
	#category : #'Lcs-SlotDefinitions-Core'
}

{ #category : #initialize }
LcsUuidSlot >> initialize [
	super initialize.
	self slotName: 'uuid'.
	self allowNil.
	self addSlotType: SmallInteger
]
