Class {
	#name : #LcsDirectVariableUpdatePolicy,
	#superclass : #LcsVariableUpdatePolicy,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #'slot model' }
LcsDirectVariableUpdatePolicy >> slotVarPut: anObject in: aDomainObject [
	self parent verifyType: anObject for: nil.
	aDomainObject instVarNamed: self parent slotName put: anObject
]
