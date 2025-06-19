Class {
	#name : #LcsStateMachineStateSlot,
	#superclass : #LcsDomainObjectSlot,
	#traits : 'LtAggregateAssociation',
	#classTraits : 'LtAggregateAssociation classTrait',
	#category : #'Lcs-StateMachine-Slot'
}

{ #category : #initialize }
LcsStateMachineStateSlot >> initialize [
	super initialize.
	self 
		slotName: 'state';
		addSlotType: LcsStateMachineState; 
		beAllowNil;
		initialValue: nil
]

{ #category : #accessing }
LcsStateMachineStateSlot >> slotVarPut: anObject in: aDomainObject [
	| originalObject |
	"More work required here as the fact that they were sapped needs to be recorded"
	originalObject := self persistedSlotVarIn: aDomainObject.
	self _slotVarPut: anObject in: aDomainObject.
	"self currentUnitOfWork deleteObject: originalObject"
]
