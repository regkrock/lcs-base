Class {
	#name : #LcsContextSlot,
	#superclass : #LcsSlotDefinition,
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #initialize }
LcsContextSlot >> initialize [
	super initialize.
	self
		slotName: 'context';
		addSlotType: Object;
		allowNil
]
