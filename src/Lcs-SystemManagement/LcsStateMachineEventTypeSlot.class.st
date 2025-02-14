Class {
	#name : #LcsStateMachineEventTypeSlot,
	#superclass : #LcsSmalltalkObjectSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #'as yet unclassified' }
LcsStateMachineEventTypeSlot >> initialize [
	super initialize.
	self
		slotName: 'type';
		beRequired
]

{ #category : #'as yet unclassified' }
LcsStateMachineEventTypeSlot >> typeClass [
	^ Symbol
]
