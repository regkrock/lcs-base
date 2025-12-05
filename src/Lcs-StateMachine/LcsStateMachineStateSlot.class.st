Class {
	#name : 'LcsStateMachineStateSlot',
	#superclass : 'LcsDomainObjectSlot',
	#traits : 'LtAggregateAssociation',
	#classTraits : 'LtAggregateAssociation classTrait',
	#category : 'Lcs-StateMachine-Slot',
	#package : 'Lcs-StateMachine',
	#tag : 'Slot'
}

{ #category : 'initialize' }
LcsStateMachineStateSlot >> initialize [
	super initialize.
	self 
		slotName: 'state';
		addSlotType: LcsStateMachineState; 
		beAllowNil;
		initialValue: nil
]

{ #category : 'slot model' }
LcsStateMachineStateSlot >> slotVarPut: anObject in: aDomainObject [
	<TODO: 'More work required here as the fact that they were swapped needs to be recorded'>

	| originalObject |
	self deprecated: 'Need to pass the old value as well'.
	originalObject := self persistedSlotVarIn: aDomainObject.
	self _slotVarPut: anObject in: aDomainObject.
	"self currentUnitOfWork deleteObject: originalObject"
]
