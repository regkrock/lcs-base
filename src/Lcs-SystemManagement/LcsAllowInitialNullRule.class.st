Class {
	#name : 'LcsAllowInitialNullRule',
	#superclass : 'LcsBaseValidationRule',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'defaults' }
LcsAllowInitialNullRule >> defaultAuditMessage [
	^ 'Null is not allowed'
]

{ #category : 'defaults' }
LcsAllowInitialNullRule >> defaultConditionBlock [
	^ [ :value :parentDomainObject :oldValue | 
		(self slotDefinition isNullObject: value) 
			ifTrue: [ 
				(self slotDefinition isInitialNullNotAllowed or: [ oldValue isNotNil ]) 
					ifTrue: [
						self 
							signalValidationError: value 
							context: parentDomainObject 
							oldValue: oldValue  ]
					ifFalse: [ true ] ]
			ifFalse: [ false ] ].
]

{ #category : 'defaults' }
LcsAllowInitialNullRule >> defaultDescription [
	^ 'Is Null Valid For Initialization Rule'
]

{ #category : 'defaults' }
LcsAllowInitialNullRule >> defaultErrorMessage [
	^ 'Attempt to initialize slot with null when in a state other than initialization'
]
