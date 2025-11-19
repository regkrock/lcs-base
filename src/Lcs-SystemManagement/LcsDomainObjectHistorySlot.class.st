Class {
	#name : 'LcsDomainObjectHistorySlot',
	#superclass : 'LcsDomainObjectSlot',
	#traits : 'LtDeleteRemovedDomainObject',
	#classTraits : 'LtDeleteRemovedDomainObject classTrait',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'as yet unclassified' }
LcsDomainObjectHistorySlot >> initialize [
	super initialize.
	self
		slotName: 'history';
		addSlotType: LcsDomainObjectHistory;
		priority: 100;
		makeDirectUpdateOfVariable
]
