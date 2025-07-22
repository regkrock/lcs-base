Class {
	#name : #LcsSlotValidationError,
	#superclass : #LcsSlotValidationBaseError,
	#category : #'Lcs-SystemManagement-Error'
}

{ #category : #'instance creation' }
LcsSlotValidationError class >> signalInvalidValue: aValue forCondition: anObject inSlot: aSlotDefinition [
	self new
		signalInvalidValue: aValue
		forCondition: anObject
		inSlot: aSlotDefinition
		context: nil
]

{ #category : #'instance creation' }
LcsSlotValidationError class >> signalInvalidValue: aValue forCondition: anObject inSlot: aSlotDefinition context: aDomainObject [
	self new
		signalInvalidValue: aValue
		forCondition: anObject
		inSlot: aSlotDefinition
		context: aDomainObject
]

{ #category : #'instance creation' }
LcsSlotValidationError >> signalInvalidValue: aValue forCondition: aValidationCondition inSlot: aSlotDefinition context: aDomainObject [
	self value: aValue.
	self validationCondition: aValidationCondition.
	self slotDefinition: aSlotDefinition.
	self context: aDomainObject.
	self signal: self validationConditionErrorMessage
]

{ #category : #'instance creation' }
LcsSlotValidationError >> validationConditionErrorMessage [
	^ '<1s> slot: <2s> has validation error: <3s>'
		expandMacrosWith: self context class name asString
		with: (self slotDefinition ifNil: [ nil ] ifNotNil: [:slotDef | slotDef slotName ]) asString
		with: self validationCondition validationDescription asString
]
