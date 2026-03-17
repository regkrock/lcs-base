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
		(self slotDefinition isNull: value) 
			ifTrue: [ true ]
			ifFalse: [ self slotDefinition ifNil: [ false ] ifNotNil: [ :slot | slot allowNull ] ] ]
]

{ #category : 'defaults' }
LcsAllowNullSlotTypeRule >> defaultDescription [
	^ 'Null validation'
]

{ #category : 'defaults' }
LcsAllowNullSlotTypeRule >> defaultErrorMessage [
	^ 'Null is not allowed in slot'
]
