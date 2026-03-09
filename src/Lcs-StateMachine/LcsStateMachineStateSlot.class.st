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
	| existingValue |
	existingValue := self persistedSlotVarIn: aDomainObject.
	self slotVarPut: anObject in: aDomainObject oldValue: existingValue.
	"(existingValue isDomainObject)
		ifTrue: [ self currentUnitOfWork deleteObject: existingValue ]"
]
