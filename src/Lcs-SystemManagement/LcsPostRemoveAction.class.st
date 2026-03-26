Class {
	#name : 'LcsPostRemoveAction',
	#superclass : 'LcsSlotAction',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'validation' }
LcsPostRemoveAction >> execute: aValue [
	^ self execute: aValue context: nil oldValue: nil
]

{ #category : 'validation' }
LcsPostRemoveAction >> execute: aValue context: aDomainObject [
	^ self execute: aValue context: aDomainObject oldValue: nil
]

{ #category : 'validation' }
LcsPostRemoveAction >> execute: aValue context: aDomainObject oldValue: anOldValue [
	[ self actionBlock
		cull: aValue
		cull: aDomainObject
		cull: anOldValue ]
		on: Error
		do: [ :s | 
			LcsSlotActionExecutionError
				signalErrorForValue: self
				updateAction: aValue
				slot: self slotDefinition
				context: aDomainObject
				oldValue: anOldValue
				smalltalkException: s ]
]
