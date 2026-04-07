Class {
	#name : 'LcsAllowNullSlotTypeRule',
	#superclass : 'LcsBaseSlotTypeRule',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'defaults' }
LcsAllowNullSlotTypeRule >> defaultConditionBlock [
	^ [ :value :parentDomainObject :oldValue | 	
		(self isNullObject: value)
			ifTrue: [ 
				self isNullAllowed
					ifTrue: [ true ]
					ifFalse: [ ^ self signalInvalidSlotTypeError: value for: parentDomainObject ] ]
			ifFalse: [ false ] ]
]

{ #category : 'defaults' }
LcsAllowNullSlotTypeRule >> defaultDescription [
	^ 'Null validation'
]

{ #category : 'defaults' }
LcsAllowNullSlotTypeRule >> defaultErrorMessage [
	^ 'Null is not allowed in slot'
]

{ #category : 'testing' }
LcsAllowNullSlotTypeRule >> isNullAllowed [
	^ self slotDefinition ifNil: [ false ] ifNotNil: [ :slot | slot allowNull ]
]

{ #category : 'testing' }
LcsAllowNullSlotTypeRule >> isNullObject: value [ 
	^ self slotDefinition ifNil: [ false ] ifNotNil: [ :slot | slot isNullObject: value  ] 
]
