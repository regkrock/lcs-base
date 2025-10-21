Class {
	#name : #LcsDirectVariableUpdatePolicy,
	#superclass : #LcsVariableUpdatePolicy,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #'slot model' }
LcsDirectVariableUpdatePolicy >> slotVarPut: anObject in: aDomainObject [
	self deprecated: 'Need to pass the old value as well'.
	self validate: anObject for: aDomainObject.
	aDomainObject instVarNamed: self parent slotName put: anObject
]

{ #category : #'slot model' }
LcsDirectVariableUpdatePolicy >> slotVarPut: anObject in: aDomainObject oldValue: existingValue [
	self validate: anObject for: aDomainObject  oldValue: existingValue.
	aDomainObject instVarNamed: self parent slotName put: anObject
]
