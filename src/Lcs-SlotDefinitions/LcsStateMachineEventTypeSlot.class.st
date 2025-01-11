Class {
	#name : #LcsStateMachineEventTypeSlot,
	#superclass : #LcsSlotDefinition,
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #'as yet unclassified' }
LcsStateMachineEventTypeSlot >> initialize [
	super initialize.
	self
		slotName: 'type';
		addSlotType: Symbol;
		beRequired
]
