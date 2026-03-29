Class {
	#name : 'LcsSlotValidationError',
	#superclass : 'LcsSlotValidationBaseError',
	#category : 'Lcs-SystemManagement-Error',
	#package : 'Lcs-SystemManagement',
	#tag : 'Error'
}

{ #category : 'instance creation' }
LcsSlotValidationError class >> signalInvalidValue: aValue forCondition: anObject inSlot: aSlotDefinition oldValue: anOldValue context: aDomainObject [
	self new
		signalInvalidValue: aValue
		forRule: anObject
		inSlot: aSlotDefinition
		context: aDomainObject
		oldValue: anOldValue
]

{ #category : 'instance creation' }
LcsSlotValidationError class >> signalInvalidValue: aValue forRule: anObject inSlot: aSlotDefinition context: aDomainObject oldValue: anOldvalue [
	self new
		signalInvalidValue: aValue
		forRule: anObject
		inSlot: aSlotDefinition
		context: aDomainObject
		oldValue: anOldvalue
]

{ #category : 'instance creation' }
LcsSlotValidationError >> auditErrorMessage [
	^ '<1s> slot: <2s> contains unexpected value: <3s>'
		expandMacrosWith: self targetDomainObject printString
		with: self slotName asString
		with: self value asString
]

{ #category : 'instance creation' }
LcsSlotValidationError >> signalInvalidValue: aValue forRule: aRule inSlot: aSlotDefinition context: aDomainObject oldValue: anOldValue [
	self value: aValue.
	self rule: aRule.
	self slotDefinition: aSlotDefinition.
	self context: aDomainObject.
	self oldValue: anOldValue.
	self signal: self validationConditionErrorMessage
]

{ #category : 'instance creation' }
LcsSlotValidationError >> targetDomainObject [
	^ self context ifNil: [ '<nil>' ]
]

{ #category : 'instance creation' }
LcsSlotValidationError >> validationConditionErrorMessage [
	^ '<1s> slot: <2s> has invalid value: <3s>'
		expandMacrosWith: (self context
				ifNil: [ '<nil>' ]
				ifNotNil: [ self context printString  ])
		with: (self slotDefinition
				ifNil: [ '<nil>' ]
				ifNotNil: [ :slotDef | slotDef slotName ])
		with: self value printString
]
