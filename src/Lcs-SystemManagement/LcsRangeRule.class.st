Class {
	#name : 'LcsRangeRule',
	#superclass : 'LcsBaseValidationRule',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'defaults' }
LcsRangeRule >> defaultAuditMessage [
	^ 'Value is out of range'
]

{ #category : 'defaults' }
LcsRangeRule >> defaultConditionBlock [
	^ [ :value :parentDomainObject :oldValue | 
		value isNil 
			ifTrue: [ true ]
			ifFalse: [ 
				((self slotDefinition minimum notNil and: [ value < self slotDefinition minimum ]) or: [
					(self slotDefinition maximum notNil) and: [ value > self slotDefinition maximum ] ])
					ifTrue: [ 
						self 
							signalValidationError: value 
							context: parentDomainObject 
							oldValue: oldValue ] 
					ifFalse: [ true ]  ] ]
]

{ #category : 'defaults' }
LcsRangeRule >> defaultDescription [
	^ 'Range validation'
]

{ #category : 'defaults' }
LcsRangeRule >> defaultErrorMessage [
	^ 'Value is out of range'
]
