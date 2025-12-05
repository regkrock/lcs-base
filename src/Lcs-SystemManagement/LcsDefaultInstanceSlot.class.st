Class {
	#name : 'LcsDefaultInstanceSlot',
	#superclass : 'LcsVirtualSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'defaults' }
LcsDefaultInstanceSlot >> defaultValueAccessBlock [
	[ :parentDomainObject | parentDomainObject defaultInstance ]
]

{ #category : 'inititalize' }
LcsDefaultInstanceSlot >> initialize [
	super initialize.
	self slotName: 'defaultInstance'
]
