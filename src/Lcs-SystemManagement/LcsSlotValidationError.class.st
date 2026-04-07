Class {
	#name : 'LcsSlotValidationError',
	#superclass : 'LcsSlotValidationBaseError',
	#category : 'Lcs-SystemManagement-Error',
	#package : 'Lcs-SystemManagement',
	#tag : 'Error'
}

{ #category : 'instance creation' }
LcsSlotValidationError class >> signalInvalidAuditValue: aValue rule: aRule inSlot: aSlotDefinition context: aDomainObject [
	self new
		signalInvalidAuditValue: aValue
		rule: aRule
		inSlot: aSlotDefinition
		context: aDomainObject
]

{ #category : 'instance creation' }
LcsSlotValidationError class >> signalInvalidAuditValue: aValue rule: aRule inSlot: aSlotDefinition oldValue: anOldValue context: aDomainObject [
	self new
		signalInvalidAuditValue: aValue
		rule: aRule
		inSlot: aSlotDefinition
		context: aDomainObject
]

{ #category : 'instance creation' }
LcsSlotValidationError class >> signalInvalidValue: aValue rule: aRule inSlot: aSlotDefinition context: aDomainObject oldValue: anOldvalue [
	self new
		signalInvalidValue: aValue
		rule: aRule
		inSlot: aSlotDefinition
		context: aDomainObject
		oldValue: anOldvalue
]

{ #category : 'instance creation' }
LcsSlotValidationError class >> signalInvalidValue: aValue rule: aRule inSlot: aSlotDefinition oldValue: anOldValue context: aDomainObject [
	^ self new
		signalInvalidValue: aValue
		rule: aRule
		inSlot: aSlotDefinition
		context: aDomainObject
		oldValue: anOldValue
]

{ #category : 'instance creation' }
LcsSlotValidationError >> auditErrorMessage [
	^ '<1p> slot: <2p> contains unexpected value: <3p>'
		expandMacrosWith: self targetDomainObject
		with: self slotName
		with: self value
]

{ #category : 'instance creation' }
LcsSlotValidationError >> signalInvalidAuditValue: aValue rule: aRule inSlot: aSlotDefinition context: aDomainObject [
	self value: aValue.
	self rule: aRule.
	self slotDefinition: aSlotDefinition.
	self context: aDomainObject.
	self oldValue: aValue.
	self signal: aRule validationErrorMessage
]

{ #category : 'instance creation' }
LcsSlotValidationError >> signalInvalidValue: aValue rule: aRule inSlot: aSlotDefinition context: aDomainObject oldValue: anOldValue [
	self value: aValue.
	self rule: aRule.
	self slotDefinition: aSlotDefinition.
	self context: aDomainObject.
	self oldValue: anOldValue.
	self signal: aRule validationErrorMessage.
	^ self
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
				ifNotNil: [ :slotDef | 
					slotDef slotName ifNil: [ '<nil>' ] ])
		with: self value printString
]
