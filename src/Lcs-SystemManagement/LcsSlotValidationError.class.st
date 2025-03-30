Class {
	#name : #LcsSlotValidationError,
	#superclass : #LcsSlotModelError,
	#instVars : [
		'value',
		'validationCondition',
		'slotDefinition'
	],
	#category : #'Lcs-SystemManagement-Tests'
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
	self signal: self validationCondition description
]

{ #category : #accessing }
LcsSlotValidationError >> slotDefinition [
	^ slotDefinition
]

{ #category : #accessing }
LcsSlotValidationError >> slotDefinition: anObject [
	slotDefinition := anObject
]

{ #category : #accessing }
LcsSlotValidationError >> validationCondition [
	^ validationCondition 
]

{ #category : #accessing }
LcsSlotValidationError >> validationCondition: aValidationCondition [ 
	validationCondition := aValidationCondition
]

{ #category : #accessing }
LcsSlotValidationError >> value [
	^ value
]

{ #category : #accessing }
LcsSlotValidationError >> value: aValue [ 
	value := aValue
]
