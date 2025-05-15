Class {
	#name : #LcsValueHistorySlot,
	#superclass : #LcsSlotDefinition,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #'as yet unclassified' }
LcsValueHistorySlot >> initialize [ 
	super initialize.
	self
		addSlotType: Object;
		makeDirectUpdateOfVariable;
		allowNil
]
