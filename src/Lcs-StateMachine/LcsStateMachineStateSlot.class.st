Class {
	#name : #LcsStateMachineStateSlot,
	#superclass : #LcsDomainObjectSlot,
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

{ #category : #accessing }
LcsStateMachineStateSlot >> slotVarPut: anObject in: aDomainObject [
	| originalObject |
	"More work required here as the fact that they were sapped needs to be recorded"
	originalObject := self persistedSlotVarIn: aDomainObject.
	self _slotVarPut: anObject in: aDomainObject.
	"self currentUnitOfWork deleteObject: originalObject"
]
