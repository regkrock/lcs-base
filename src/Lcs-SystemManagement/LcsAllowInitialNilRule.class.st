Class {
	#name : 'LcsAllowInitialNilRule',
	#superclass : 'LcsBaseValidationRule',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'defaults' }
LcsAllowInitialNilRule >> defaultConditionBlock [
	^ [ :value :parentDomainObject :oldValue | 
		self isValidValue: value domainObject: parentDomainObject oldValue: oldValue ]
]

{ #category : 'defaults' }
LcsAllowInitialNilRule >> defaultDescription [
	^ 'Nil Valid For Initialization Rule'
]

{ #category : 'defaults' }
LcsAllowInitialNilRule >> defaultErrorMessage [
	^ 'Attempt to initialize slot with nil when in a state other than initialization'
]

{ #category : 'testing' }
LcsAllowInitialNilRule >> isValidValue: value domainObject: parentDomainObject oldValue: oldValue [
	value isNil ifFalse: [ ^ false ].
	self slotDefinition isNilAllowed ifFalse: [ self signalValidationError: value context: parentDomainObject oldValue: oldValue  ].
	oldValue isLcsUndefinedObject ifFalse: [ self signalValidationError: value context: parentDomainObject oldValue: oldValue  ].
	^ true

]
