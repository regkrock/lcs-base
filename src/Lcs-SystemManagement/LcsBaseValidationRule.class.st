Class {
	#name : 'LcsBaseValidationRule',
	#superclass : 'LcsBaseRule',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'validation' }
LcsBaseValidationRule >> validate: aValue context: aDomainObject oldValue: anOldValue [
	^self conditionBlock
		cull: aValue
		cull: aDomainObject
		cull: anOldValue 
]
