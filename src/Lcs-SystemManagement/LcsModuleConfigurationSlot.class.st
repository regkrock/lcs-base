Class {
	#name : 'LcsModuleConfigurationSlot',
	#superclass : 'LcsDomainObjectSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'instance creation' }
LcsModuleConfigurationSlot class >> newOn: aConfigurationClass [
	^ self new
		initializeOn: aConfigurationClass;
		yourself
]

{ #category : 'object initialization' }
LcsModuleConfigurationSlot >> defaultInitialValueBlock [
	^ [ :parentDomainObject :slot | 
		(slot slotTypes any basicNew)
			parent: parentDomainObject;
			yourself ]
]

{ #category : 'defaults' }
LcsModuleConfigurationSlot >> defaultPriority [
	^ 75
]

{ #category : 'initialize' }
LcsModuleConfigurationSlot >> initialize [
	super initialize.
	self slotName: 'configuration'
]

{ #category : 'initialize' }
LcsModuleConfigurationSlot >> initializeOn: aConfigurationClass [ 
	self addSlotType: aConfigurationClass
]

{ #category : 'object initialization' }
LcsModuleConfigurationSlot >> initializeSlotValueIn: aDomainObject [
	| initialValue |
	LcsLogger logReceiver: thisContext receiver message: thisContext message.
	LcsLogger indent.
	initialValue := self initialValueFor: aDomainObject.
	self slotVarPut: initialValue in: aDomainObject.
	initialValue initialize.
	LcsLogger outdent.
]
