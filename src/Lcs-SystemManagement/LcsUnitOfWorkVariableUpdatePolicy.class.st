Class {
	#name : 'LcsUnitOfWorkVariableUpdatePolicy',
	#superclass : 'LcsVariableUpdatePolicy',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'slot model' }
LcsUnitOfWorkVariableUpdatePolicy >> slotVarPut: anObject in: aDomainObject [
	self validate: anObject context: aDomainObject.
	LcsLogger logReceiver: thisContext receiver message: thisContext message.
	self currentUnitOfWork
		setValueIn: aDomainObject
		slot: self parent
		to: anObject
	
]

{ #category : 'slot model' }
LcsUnitOfWorkVariableUpdatePolicy >> slotVarPut: anObject in: aDomainObject oldValue: anOldValue [
	| transformedObject |
	self validate: anObject context: aDomainObject oldValue: anOldValue.
	LcsLogger logReceiver: thisContext receiver message: thisContext message inSlotNamed: self parent slotName.
	transformedObject := self parent presaveTransformBlock
			cull: anObject
			cull: aDomainObject
			cull: anOldValue.
	self currentUnitOfWork
		setValueIn: aDomainObject
		slot: self parent
		to: transformedObject
	
]
