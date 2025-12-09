Class {
	#name : 'LcsPostAddAction',
	#superclass : 'LcsSlotAction',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'validation' }
LcsPostAddAction >> execute: aValue [
	^ self execute: aValue context: nil oldValue: nil
]

{ #category : 'validation' }
LcsPostAddAction >> execute: aValue context: aDomainObject [
	^ self execute: aValue context: aDomainObject oldValue: nil
]

{ #category : 'validation' }
LcsPostAddAction >> execute: aValue context: aDomainObject oldValue: anOldValue [
	[ self actionBlock cull: aValue cull: aDomainObject cull: anOldValue ]
		on: Error
		do: [ :s | 
				LcsUpdateActionExecutionError
					signalErrForValue: aValue
					updateAction: self
					slot: self slotDefinition
					context: aDomainObject
					oldValue: anOldValue
					message: s message asString ]
]
