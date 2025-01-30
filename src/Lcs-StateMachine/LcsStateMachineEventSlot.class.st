Class {
	#name : #LcsStateMachineEventSlot,
	#superclass : #LcsDomainObjectSlot,
	#traits : 'LtAggregateComponent',
	#classTraits : 'LtAggregateComponent classTrait',
	#category : #'Lcs-StateMachine-Slot'
}

{ #category : #initialize }
LcsStateMachineEventSlot >> initialize [
	super initialize.
	self addSlotType: #LcsStateMachineEvent asClass. 
	self allowNil

]
