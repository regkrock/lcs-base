Class {
	#name : 'LcsAllowNilRule',
	#superclass : 'LcsBaseValidationRule',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'defaults' }
LcsAllowNilRule >> defaultConditionBlock [
	^ [ :value :parentDomainObject :oldValue | 
		(value isNil) 
			ifTrue: [
				self slotDefinition isNilAllowed 
					ifTrue: [ true]
					ifFalse: [ self 
								signalValidationError: value 
								context: parentDomainObject 
								oldValue: oldValue  ] ]
			ifFalse: [ false ] ]
]

{ #category : 'defaults' }
LcsAllowNilRule >> defaultDescription [
	^ 'Is Nil Valid Rule'
]

{ #category : 'defaults' }
LcsAllowNilRule >> defaultErrorMessage [
	^ 'Attempt to set slot to nil when nil not allowed'
]
