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
	^ [ '<1s> is not in the slot types list' expandMacrosWith: self slotDefinition printString ]
]

{ #category : 'slot' }
LcsClassIsMemberSlotTypesRule >> slotTypes [
	^ self slotDefinition slotTypes
]
