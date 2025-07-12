Class {
	#name : #LcsStateMachineEventTypeSlot,
	#superclass : #LcsSmalltalkObjectSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #defaults }
LcsStateMachineEventTypeSlot >> defaultInitialValueBlock [
	^ [ :domainObject :slot | #'' ]
]

{ #category : #initialize }
LcsStateMachineEventTypeSlot >> initialize [
	super initialize.
	self
		slotName: 'type';
		beRequired
]

{ #category : #configuration }
LcsStateMachineEventTypeSlot >> typeClass [
	^ Symbol
]
