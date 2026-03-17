Class {
	#name : 'LcsBaseSlotTypeRule',
	#superclass : 'LcsBaseRule',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'error signalling' }
LcsBaseSlotTypeRule >> signalInvalidSlotTypeError: value for: aDomainObject [ 
	^ LcsInvalidSlotTypeError
		signalInvalidType: value
		forSlot: self slotDefinition
		for: aDomainObject
]

{ #category : 'validation' }
LcsBaseSlotTypeRule >> validate: aValue context: aDomainObject oldValue: anOldValue [
	^ [ self conditionBlock cull: aValue cull: aDomainObject cull: anOldValue ]
		on: LcsError
		do: [ :s | s signal ];
		on: Error
		do: [ :s | 
					LcsSlotValidationExecutionError
						signalInvalidValue: aValue
						forRule: self
						inSlot: self slotDefinition
						context: aDomainObject
						oldValue: anOldValue
						message: s messageText ]
]
