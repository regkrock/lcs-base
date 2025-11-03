Class {
	#name : #LcsSystemStatusSlot,
	#superclass : #LcsDomainObjectSlot,
	#traits : 'LtDeleteRemovedDomainObject',
	#classTraits : 'LtDeleteRemovedDomainObject classTrait',
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #initialize }
LcsSystemStatusSlot >> initialize [
	super initialize.
	self 
		slotName: 'status';
		addSlotType: LcsBaseSystemStatus;
		initialValueBlock: [ :domainParent | 
			(LcsSystemActiveStatus new)
				parent: domainParent;
				yourself]
]
