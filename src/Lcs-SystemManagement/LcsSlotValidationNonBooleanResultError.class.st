Class {
	#name : 'LcsSlotValidationNonBooleanResultError',
	#superclass : 'LcsSlotValidationBaseError',
	#category : 'Lcs-SystemManagement-Error',
	#package : 'Lcs-SystemManagement',
	#tag : 'Error'
}

{ #category : 'instance creation' }
LcsSlotValidationNonBooleanResultError class >> signalBooleanNotReturnedFor: aValue rule: anObject inSlot: aSlotDefinition context: aDomainObject oldValue: anOldValue [
	self new
		signalBooleanNotReturnedFor: aValue
		rule: anObject
		inSlot: aSlotDefinition
		context: aDomainObject
		oldValue: anOldValue
]

{ #category : 'instance creation' }
LcsSlotValidationNonBooleanResultError >> signalBooleanNotReturnedFor: aValue rule: aRule inSlot: aSlotDefinition context: aDomainObject oldValue: anOldValue [
	self value: aValue.
	self rule: aRule.
	self slotDefinition: aSlotDefinition.
	self context: aDomainObject.
	self oldValue: anOldValue.
	self signal: self validationConditionErrorMessage
]

{ #category : 'instance creation' }
LcsSlotValidationNonBooleanResultError >> validationConditionErrorMessage [
	^ '<1s> slot: <2s> has validation error: <3s>'
		expandMacrosWith: self context class name asString
		with: (self slotDefinition ifNil: [ nil ] ifNotNil: [:slotDef | slotDef slotName ]) asString
		with: self rule description asString
]
