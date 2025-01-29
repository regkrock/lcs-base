Class {
	#name : #LcsObjectVersionSlot,
	#superclass : #LcsSlotDefinition,
	#category : #'Lcs-SlotDefinitions-Core'
}

{ #category : #initialize }
LcsObjectVersionSlot >> initialize [
	super initialize.
	self slotName: 'version'.
	self initialValue: 0.
	self addSlotType: SmallInteger
]
