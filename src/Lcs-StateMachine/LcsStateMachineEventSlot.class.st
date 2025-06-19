Class {
	#name : #LcsStateMachineEventSlot,
	#superclass : #LcsDomainObjectSlot,
	#traits : 'LtAggregateAssociation',
	#classTraits : 'LtAggregateAssociation classTrait',
	#category : #'Lcs-StateMachine-Slot'
}

{ #category : #initialize }
LcsStateMachineEventSlot >> initialize [
	super initialize.
	self addSlotType: #LcsStateMachineEvent asClass. 
	self beAllowNil.
	self initialValue: nil

]
