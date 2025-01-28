Class {
	#name : #LcsStateMachineStateSlot,
	#superclass : #LcsSlotDefinition,
	#traits : 'LtAggregateComponent',
	#classTraits : 'LtAggregateComponent classTrait',
	#category : #'Lcs-StateMachine-Slot'
}

{ #category : #initialize }
LcsStateMachineStateSlot >> initialize [
	super initialize.
	self 
		slotName: 'state';
		addSlotType: LcsStateMachineState; 
		allowNil
]
