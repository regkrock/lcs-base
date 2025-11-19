Class {
	#name : 'LcsSingletonCodeIsDefaultInstanceSlot',
	#superclass : 'LcsBooleanSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'initialize' }
LcsSingletonCodeIsDefaultInstanceSlot >> defaultInitialValueBlock [
	^ [ :parentDomainObject | parentDomainObject class defaultInstance ]
]

{ #category : 'initialize' }
LcsSingletonCodeIsDefaultInstanceSlot >> initialize [
	super initialize.
	self slotName: 'isDefaultInstance'
]
