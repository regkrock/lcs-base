Class {
	#name : #LcsStateMachineEventTypeSlot,
	#superclass : #LcsSlotDefinition,
	#category : #'Lcs-SlotDefinitions-Core'
}

{ #category : #'as yet unclassified' }
LcsStateMachineEventTypeSlot >> initialize [
	super initialize.
	self
		slotName: 'type';
		addSlotType: Symbol;
		beRequired
]
