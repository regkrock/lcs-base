Class {
	#name : #LcsSlotValidationNonBooleanResultError,
	#superclass : #LcsSlotValidationBaseError,
	#category : #'Lcs-SystemManagement-Tests'
}

{ #category : #'instance creation' }
LcsSlotValidationNonBooleanResultError class >> signalBooleanNotReturnedFor: aValue condition: anObject inSlot: aSlotDefinition [
	self new
		signalBooleanNotReturnedFor: aValue
		condition: anObject
		inSlot: aSlotDefinition
]

{ #category : #'instance creation' }
LcsSlotValidationNonBooleanResultError >> signalBooleanNotReturnedFor: aValue condition: aValidationCondition inSlot: aSlotDefinition [
	self value: aValue.
	self validationCondition: aValidationCondition.
	self slotDefinition: aSlotDefinition.
	self context: nil.
	self signal: self validationConditionErrorMessage
]

{ #category : #'instance creation' }
LcsSlotValidationNonBooleanResultError >> validationConditionErrorMessage [
	^ '<1s> slot: <2s> has validation error: <3s>'
		expandMacrosWith: self context class name asString
		with: (self slotDefinition ifNil: [ nil ] ifNotNil: [:slotDef | slotDef slotName ]) asString
		with: self validationCondition validationDescription asString
]
