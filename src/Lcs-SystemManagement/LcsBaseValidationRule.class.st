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
		on: MessageNotUnderstood
		do: [ :signal |
				^ LcsSlotValidationError
					signalInvalidAuditValue: aValue 
					rule: self 
					inSlot: self slotDefinition 
					context: aDomainObject
					]
]

{ #category : 'validation' }
LcsBaseValidationRule >> validate: aValue context: aDomainObject oldValue: anOldValue [
	^self conditionBlock
		cull: aValue
		cull: aDomainObject
		cull: anOldValue 
]
