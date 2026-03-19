Class {
	#name : 'LcsAllowInitialNullRule',
	#superclass : 'LcsBaseValidationRule',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'defaults' }
LcsAllowInitialNullRule >> defaultConditionBlock [
	^ [ :value :parentDomainObject :oldValue | 
		self isValidValue: value domainObject: parentDomainObject oldValue: oldValue ]
]

{ #category : 'defaults' }
LcsAllowInitialNullRule >> defaultDescription [
	^ 'Is Null Valid For Initialization Rule'
]

{ #category : 'defaults' }
LcsAllowInitialNullRule >> defaultErrorMessage [
	^ 'Attempt to initialize slot with null when in a state other than initialization'
]

{ #category : 'testing' }
LcsAllowInitialNullRule >> isValidValue: value domainObject: parentDomainObject oldValue: oldValue [
	(self slotDefinition isNullObject: value) ifFalse: [ ^ false ].
	self slotDefinition isNullAllowed ifFalse: [ self signalValidationError: value context: parentDomainObject oldValue: oldValue  ].
	oldValue isNil ifFalse: [ self signalValidationError: value context: parentDomainObject oldValue: oldValue  ].
	^ true

]
