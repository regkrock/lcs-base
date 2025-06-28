Class {
	#name : #LcsDirectVariableUpdatePolicy,
	#superclass : #LcsVariableUpdatePolicy,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #'slot model' }
LcsDirectVariableUpdatePolicy >> slotVarPut: anObject in: aDomainObject [
	self validate: anObject for: aDomainObject.
	aDomainObject instVarNamed: self parent slotName put: anObject
]
