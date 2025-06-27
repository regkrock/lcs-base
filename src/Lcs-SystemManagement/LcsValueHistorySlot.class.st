Class {
	#name : #LcsValueHistorySlot,
	#superclass : #LcsAcessorSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #'as yet unclassified' }
LcsValueHistorySlot >> initialize [ 
	super initialize.
	self
		addSlotType: Object;
		makeDirectUpdateOfVariable;
		beAllowNil;
		initialValue: nil
]
