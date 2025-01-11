Class {
	#name : #LcsStateMachineEventSlot,
	#superclass : #LcsAggregateSlot,
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #'as yet unclassified' }
LcsStateMachineEventSlot >> initialize [
	super initialize.
	self addSlotType: LcsStateMachineEvent. 
	self allowNil

]
