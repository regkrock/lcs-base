Class {
	#name : #LcsParentSlot,
	#superclass : #LcsSlotDefintion,
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #accessing }
LcsParentSlot >> initialize [
	super initialize.
	self slotName: 'parent'.
]
