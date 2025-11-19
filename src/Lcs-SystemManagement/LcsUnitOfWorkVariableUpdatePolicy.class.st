Class {
	#name : 'LcsUnitOfWorkVariableUpdatePolicy',
	#superclass : 'LcsVariableUpdatePolicy',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'slot model' }
LcsUnitOfWorkVariableUpdatePolicy >> slotVarPut: anObject in: aDomainObject [
	self deprecated: 'Need to pass the old value as well'.
	self validate: anObject for: aDomainObject.
	LcsLogger logReceiver: thisContext receiver message: thisContext message.
	self currentUnitOfWork
		setValueIn: aDomainObject
		slot: self parent
		to: anObject
	
]

{ #category : 'slot model' }
LcsUnitOfWorkVariableUpdatePolicy >> slotVarPut: anObject in: aDomainObject oldValue: anOldValue [
	self validate: anObject for: aDomainObject oldValue: anOldValue.
	LcsLogger logReceiver: thisContext receiver message: thisContext message.
	self currentUnitOfWork
		setValueIn: aDomainObject
		slot: self parent
		to: anObject
	
]
