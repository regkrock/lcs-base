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
	self validate: anObject context: aDomainObject oldValue: anOldValue.
	LcsLogger logReceiver: thisContext receiver message: thisContext message.
	self currentUnitOfWork
		setValueIn: aDomainObject
		slot: self parent
		to: anObject
	
]
