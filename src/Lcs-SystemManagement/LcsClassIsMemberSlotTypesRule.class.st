Class {
	#name : 'LcsClassIsMemberSlotTypesRule',
	#superclass : 'LcsBaseSlotTypeRule',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'defaults' }
LcsClassIsMemberSlotTypesRule >> defaultConditionBlock [
	^ [ :value :parentDomainObject :oldValue | 
	self slotTypes
		detect: [ :eachClass | value = eachClass ]
		ifNone: [ ^ self signalInvalidSlotTypeError: value for: parentDomainObject ].
	true ]
]

{ #category : 'defaults' }
LcsClassIsMemberSlotTypesRule >> defaultDescription [
	^ 'Valid Class Type'
]

{ #category : 'defaults' }
LcsClassIsMemberSlotTypesRule >> defaultErrorMessage [
	^ 'Class is not in slot types'
]

{ #category : 'slot' }
LcsClassIsMemberSlotTypesRule >> slotTypes [
	^ self slotDefinition slotTypes
]
