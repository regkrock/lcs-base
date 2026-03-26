Class {
	#name : 'LcsSlotValidationExecutionError',
	#superclass : 'LcsSlotValidationBaseError',
	#instVars : [
		'smalltalkException'
	],
	#category : 'Lcs-SystemManagement-Error',
	#package : 'Lcs-SystemManagement',
	#tag : 'Error'
}

{ #category : 'instance creation' }
LcsSlotValidationExecutionError class >> signalInvalidValue: aValue forRule: anObject inSlot: aSlotDefinition context: aDomainObject oldValue: anOldValue parentException: anException [
	self new
		signalInvalidValue: aValue
		forRule: anObject
		inSlot: aSlotDefinition
		context: aDomainObject
		oldValue: anOldValue
		parentException: anException
]

{ #category : 'instance creation' }
LcsSlotValidationExecutionError >> signalInvalidValue: aValue forRule: aRule inSlot: aSlotDefinition context: aDomainObject oldValue: anOldValue parentException: anException [
	self value: aValue.
	self rule: aRule.
	self slotDefinition: aSlotDefinition.
	self context: aDomainObject.
	self oldValue: anOldValue.
	self smalltalkException: anException.
	self signal: self validationConditionErrorMessage , ' - Caused by ' , anException messageText.
]

{ #category : 'accessing' }
LcsSlotValidationExecutionError >> smalltalkException [
	^ smalltalkException
]

{ #category : 'accessing' }
LcsSlotValidationExecutionError >> smalltalkException: anObject [
	smalltalkException := anObject
]

{ #category : 'instance creation' }
LcsSlotValidationExecutionError >> validationConditionErrorMessage [
	^ '<1s> slot: <2s> has validation error: <3s>'
		expandMacrosWith: self context class name asString
		with: (self slotDefinition ifNil: [ nil ] ifNotNil: [:slotDef | slotDef slotName ]) asString
		with: self rule validationErrorMessage
]
