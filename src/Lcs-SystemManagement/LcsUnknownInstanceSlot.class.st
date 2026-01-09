Class {
	#name : 'LcsUnknownInstanceSlot',
	#superclass : 'LcsDomainObjectSlot',
	#traits : 'LtDeleteRemovedDomainObject',
	#classTraits : 'LtDeleteRemovedDomainObject classTrait',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'initialize' }
LcsUnknownInstanceSlot >> initialize [
	super initialize.
	self slotName: 'unknownInstance';
	priority: 60
]
