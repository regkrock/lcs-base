Class {
	#name : #LcsSlotValidationExecutionError,
	#superclass : #LcsSlotValidationBaseError,
	#category : #'Lcs-SystemManagement-Error'
}

{ #category : #'instance creation' }
LcsSlotValidationExecutionError class >> signalInvalidValue: aValue forCondition: anObject inSlot: aSlotDefinition context: aDomainObject oldValue: anOldValue message: aString [
	self new
		signalInvalidValue: aValue
		forCondition: anObject
		inSlot: aSlotDefinition
		context: aDomainObject
		oldValue: anOldValue
		message: aString
]

{ #category : #'instance creation' }
LcsSlotValidationExecutionError >> signalInvalidValue: aValue forCondition: aValidationCondition inSlot: aSlotDefinition context: aDomainObject oldValue: anOldValue message: aString [
	self value: aValue.
	self validationCondition: aValidationCondition.
	self slotDefinition: aSlotDefinition.
	self context: aDomainObject.
	self signal: self validationConditionErrorMessage , ' - Caused by ' , aString.
	self oldValue: anOldValue
]

{ #category : #'instance creation' }
LcsSlotValidationExecutionError >> validationConditionErrorMessage [
	^ '<1s> slot: <2s> has validation error: <3s>'
		expandMacrosWith: self context class name asString
		with: (self slotDefinition ifNil: [ nil ] ifNotNil: [:slotDef | slotDef slotName ]) asString
		with: self validationCondition validationDescription asString
]
