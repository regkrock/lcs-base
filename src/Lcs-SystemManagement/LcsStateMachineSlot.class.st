Class {
	#name : 'LcsStateMachineSlot',
	#superclass : 'LcsDomainObjectSlot',
	#traits : 'LtDeleteRemovedDomainObject',
	#classTraits : 'LtDeleteRemovedDomainObject classTrait',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'instance creation' }
LcsStateMachineSlot class >> newOn: aStateMachineClass [
	^ self new
		initializeOn: aStateMachineClass
		yourself
]

{ #category : 'initialize' }
LcsStateMachineSlot >> initialize [
	super initialize.
	self slotName: 'status'
]

{ #category : 'initialize' }
LcsStateMachineSlot >> initializeOn: aStateMachineClass [ 
	self addSlotType: aStateMachineClass
]

{ #category : 'slot model' }
LcsStateMachineSlot >> slotVarPut: anObject in: aDomainObject [
	| existingValue |
	existingValue := self persistedSlotVarIn: aDomainObject.
	self slotVarPut: anObject in: aDomainObject oldValue: existingValue.
	(existingValue isDomainObject)
		ifTrue: [ self currentUnitOfWork deleteObject: existingValue ]
]
