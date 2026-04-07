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
		(self slotDefinition isNullObject: value) 
			ifTrue: [
				self slotDefinition isNullAllowed 
					ifTrue: [ true]
					ifFalse: [ self 
								signalValidationError: value 
								context: parentDomainObject 
								oldValue: oldValue  ] ]
			ifFalse: [ false ] ]
]

{ #category : 'defaults' }
LcsAllowNullRule >> defaultDescription [
	^ 'Is Null Valid Rule'
]

{ #category : 'defaults' }
LcsAllowNullRule >> defaultErrorMessage [
	^ 'Attempt to set slot to null when null not allowed'
]
