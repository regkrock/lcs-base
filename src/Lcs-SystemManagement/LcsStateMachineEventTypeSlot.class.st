Class {
	#name : 'LcsStateMachineEventTypeSlot',
	#superclass : 'LcsBaseSmalltalkObjectSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'defaults' }
LcsStateMachineEventTypeSlot >> defaultInitialValueBlock [
	^ [ :parentDomainObject :slot | #'' ]
]

{ #category : 'initialize' }
LcsStateMachineEventTypeSlot >> initialize [
	super initialize.
	self
		slotName: 'type';
		beRequired
]

{ #category : 'configuration' }
LcsStateMachineEventTypeSlot >> typeClass [
	^ Symbol
]
