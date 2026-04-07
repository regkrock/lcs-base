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
		value isNil 
			ifTrue: [
				(self slotDefinition isNilNotAllowed or: [ oldValue isLcsUndefinedObject not ])
					ifTrue: [ 
						self 
							signalValidationError: value 
							context: parentDomainObject 
							oldValue: oldValue ] 
					ifFalse: [ true ] ]
			ifFalse: [ false ] ]
]

{ #category : 'defaults' }
LcsAllowInitialNilRule >> defaultDescription [
	^ 'Nil Valid For Initialization Rule'
]

{ #category : 'defaults' }
LcsAllowInitialNilRule >> defaultErrorMessage [
	^ 'Attempt to initialize slot with nil when in a state other than initialization'
]
