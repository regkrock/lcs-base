Class {
	#name : #LcsPrimitiveSlot,
	#superclass : #LcsSlotDefintion,
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #initialization }
LcsPrimitiveSlot >> initialize [
	super initialize.
	self addSlotType: self typeClass
]
