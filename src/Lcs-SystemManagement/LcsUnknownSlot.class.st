Class {
	#name : #LcsUnknownSlot,
	#superclass : #LcsDomainObjectSlot,
	#traits : 'LtDeleteRemovedDomainObject',
	#classTraits : 'LtDeleteRemovedDomainObject classTrait',
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #initialize }
LcsUnknownSlot >> initialize [
	super initialize.
	self slotName: 'unknown'
]
