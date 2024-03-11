Class {
	#name : #LcsPrimitiveSlotDefinition,
	#superclass : #LcsSlotDefinition,
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #initialization }
LcsPrimitiveSlotDefinition >> initialize [
	super initialize.
	self addSlotType: self typeClass
]
