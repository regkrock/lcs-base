Class {
	#name : 'LcsBaseValidationRule',
	#superclass : 'LcsBaseRule',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'validation' }
LcsBaseValidationRule >> audit: aValue context: aDomainObject [
	^ [ self conditionBlock
			cull: aValue
			cull: aDomainObject
			cull: aValue ]
		on: Error
		do: [ :signal |
				^ LcsSlotValidationError new
					value: aValue;
					oldValue: aValue;
					rule: self;
					slotDefinition: self slotDefinition;
					context: aDomainObject;
					smalltalkException: signal;
					signal: self validationErrorMessage]
]

{ #category : 'validation' }
LcsBaseValidationRule >> validate: aValue context: aDomainObject oldValue: anOldValue [
	^self conditionBlock
		cull: aValue
		cull: aDomainObject
		cull: anOldValue 
]
