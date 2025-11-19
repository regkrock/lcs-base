Class {
	#name : 'LcsDefaultInstanceSlot',
	#superclass : 'LcsVirtualSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'defaults' }
LcsDefaultInstanceSlot >> defaultValueAccessBlock [
	[ :domainCollection | domainCollection defaultInstance ]
]

{ #category : 'inititalize' }
LcsDefaultInstanceSlot >> initialize [
	super initialize.
	self slotName: 'defaultInstance'
]
