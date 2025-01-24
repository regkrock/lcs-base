Class {
	#name : #LcsStateMachineEventSlot,
	#superclass : #LcsAggregateSlot,
	#category : #'Lcs-StateMachine'
}

{ #category : #'as yet unclassified' }
LcsStateMachineEventSlot >> initialize [
	super initialize.
	self addSlotType: #LcsStateMachineEvent asClass. 
	self allowNil

]
