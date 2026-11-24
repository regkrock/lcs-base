Class {
	#name : 'LcsDirectVariableUpdatePolicy',
	#superclass : 'LcsVariableUpdatePolicy',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'slot model' }
LcsDirectVariableUpdatePolicy >> slotVarPut: anObject in: aDomainObject [
	self validate: anObject context: aDomainObject.
	aDomainObject instVarNamed: self parent slotName put: anObject
]

{ #category : 'slot model' }
LcsDirectVariableUpdatePolicy >> slotVarPut: anObject in: aDomainObject oldValue: existingValue [
	| transformedObject |
	self validate: anObject context: aDomainObject  oldValue: existingValue.
	transformedObject := self parent presaveTransformBlock
			cull: anObject
			cull: self
			cull: aDomainObject.
	aDomainObject instVarNamed: self parent slotName put: anObject
]
