Class {
	#name : 'LcsAllowNullRule',
	#superclass : 'LcsBaseValidationRule',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'defaults' }
LcsAllowNullRule >> defaultConditionBlock [
	^ [ :value :parentDomainObject :oldValue | 
		self isValidIValue: value domainObject: parentDomainObject oldValue: oldValue ]
]

{ #category : 'defaults' }
LcsAllowNullRule >> defaultDescription [
	^ 'Is Null Valid Rule'
]

{ #category : 'defaults' }
LcsAllowNullRule >> defaultErrorMessage [
	^ 'Attempt to set slot to null when null not allowed'
]

{ #category : 'testing' }
LcsAllowNullRule >> isValidValue: value domainObject: parentDomainObject oldValue: oldValue [
	(self slotDefinition isNullObject: value) ifFalse: [ ^ true ].
	self slotDefinition isNullAllowed ifFalse: [ self signalValidationError: value context: parentDomainObject oldValue: oldValue  ].
	^ true
]
