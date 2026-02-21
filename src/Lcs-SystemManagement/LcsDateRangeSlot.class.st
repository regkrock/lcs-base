Class {
	#name : 'LcsDateRangeSlot',
	#superclass : 'LcsDomainObjectSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'initialize' }
LcsDateRangeSlot >> initialize [
	super initialize.
	self addSlotType: LcsDateRange
]
