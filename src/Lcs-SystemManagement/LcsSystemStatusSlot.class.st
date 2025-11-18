Class {
	#name : #LcsSystemStatusSlot,
	#superclass : #LcsDomainObjectSlot,
	#traits : 'LtDeleteRemovedDomainObject',
	#classTraits : 'LtDeleteRemovedDomainObject classTrait',
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #initialize }
LcsSystemStatusSlot >> defaultInitialValueBlock [
	^ [ :parentDomainObject | 
	LcsSystemActiveStatus new
		parent: parentDomainObject;
		yourself ]
]

{ #category : #initialize }
LcsSystemStatusSlot >> initialize [
	super initialize.
	self
		slotName: 'status';
		addSlotType: LcsBaseSystemStatus
]
