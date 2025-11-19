Class {
	#name : 'LcsUuidSlot',
	#superclass : 'LcsSmalltalkObjectSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'defaults' }
LcsUuidSlot >> defaultInitialValueBlock [
	^ [ :parentDomainObject :slot | UUID new asInteger ]
]

{ #category : 'defaults' }
LcsUuidSlot >> initialize [
	super initialize.
	self 
		slotName: 'uuid';
		priority: 100
]

{ #category : 'configuration' }
LcsUuidSlot >> typeClass [
	^ Integer
]
