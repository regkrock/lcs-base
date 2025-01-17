Class {
	#name : #LcsStateMachineStateSlot,
	#superclass : #LcsAggregateSlot,
	#category : #'Lcs-StateMachine-Core'
}

{ #category : #initialize }
LcsStateMachineStateSlot >> initialize [
	super initialize.
	self 
		slotName: 'state';
		addSlotType: LcsStateMachineState; 
		allowNil
]
