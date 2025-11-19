Class {
	#name : 'LcsValueHistorySlot',
	#superclass : 'LcsAccessorSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'initialize' }
LcsValueHistorySlot >> initialize [ 
	super initialize.
	self
		addSlotType: Object;
		makeDirectUpdateOfVariable;
		beAllowNil;
		initialValue: nil
]
