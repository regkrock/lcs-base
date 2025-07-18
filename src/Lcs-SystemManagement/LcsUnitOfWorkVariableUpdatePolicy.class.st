Class {
	#name : #LcsUnitOfWorkVariableUpdatePolicy,
	#superclass : #LcsVariableUpdatePolicy,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #'slot model' }
LcsUnitOfWorkVariableUpdatePolicy >> slotVarPut: anObject in: aDomainObject [
	self validate: anObject for: aDomainObject.
	self currentUnitOfWork
		setValueIn: aDomainObject
		slot: self parent
		to: anObject
	
]
