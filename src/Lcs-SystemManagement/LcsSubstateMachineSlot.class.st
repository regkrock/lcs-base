Class {
	#name : 'LcsSubstateMachineSlot',
	#superclass : 'LcsDomainObjectSlot',
	#traits : 'LtDeleteRemovedDomainObject',
	#classTraits : 'LtDeleteRemovedDomainObject classTrait',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'initialize' }
LcsSubstateMachineSlot >> initialize [
	super initialize.
	self 		
		slotName: 'subStateMachine';
		addSlotType: LcsStateMachine
]
