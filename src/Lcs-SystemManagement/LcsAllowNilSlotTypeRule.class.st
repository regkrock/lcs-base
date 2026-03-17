Class {
	#name : 'LcsAllowNilSlotTypeRule',
	#superclass : 'LcsBaseSlotTypeRule',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'defaults' }
LcsAllowNilSlotTypeRule >> defaultConditionBlock [
	^ [ :value :parentDomainObject :oldValue | 
	value isNil
		ifTrue: [ self isNilAllowed
				ifTrue: [ true ]
				ifFalse: [ self signalInvalidSlotTypeError: value for: parentDomainObject ] ]
		ifFalse: [ false ] ]
]

{ #category : 'defaults' }
LcsAllowNilSlotTypeRule >> defaultDescription [
	^ 'Nil validation'
]

{ #category : 'defaults' }
LcsAllowNilSlotTypeRule >> defaultErrorMessage [
	^ 'Nil is not allowed in slot'
]

{ #category : 'testing' }
LcsAllowNilSlotTypeRule >> isNilAllowed [
	^ self slotDefinition ifNil: [ false ] ifNotNil: [ :slot | slot allowNil ] 
]
