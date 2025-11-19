Class {
	#name : 'LcsUnknownSlot',
	#superclass : 'LcsDomainObjectSlot',
	#traits : 'LtDeleteRemovedDomainObject',
	#classTraits : 'LtDeleteRemovedDomainObject classTrait',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'initialize' }
LcsUnknownSlot >> initialize [
	super initialize.
	self slotName: 'unknown'
]
