Class {
	#name : 'LcsUpdateAction',
	#superclass : 'LcsSlotAction',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'validation' }
LcsUpdateAction >> execute: aValue [
	^ self execute: aValue context: nil oldValue: nil
]

{ #category : 'validation' }
LcsUpdateAction >> execute: aValue context: aDomainObject [
	^ self execute: aValue context: aDomainObject oldValue: nil
]

{ #category : 'validation' }
LcsUpdateAction >> execute: aValue context: aDomainObject oldValue: anOldValue [
	[ self actionBlock cull: aValue cull: aDomainObject cull: anOldValue ]
		on: Error
		do: [ :s | 
				LcsUpdateActionExecutionError
					signalErrForValue: aValue
					updateAction: self
					slot: self slotDefinition
					context: aDomainObject
					oldValue: anOldValue
					message: s messageText asString ]
]

{ #category : 'initialize' }
LcsUpdateAction >> initialize [
	super initialize.
	self actionBlock: self defaultActionBlock
]
