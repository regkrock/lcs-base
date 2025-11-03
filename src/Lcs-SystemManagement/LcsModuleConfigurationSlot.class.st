Class {
	#name : #LcsModuleConfigurationSlot,
	#superclass : #LcsDomainObjectSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #'instance creation' }
LcsModuleConfigurationSlot class >> newOn: aConfigurationClass [
	^ self new
		initializeOn: aConfigurationClass;
		yourself
]

{ #category : #defaults }
LcsModuleConfigurationSlot >> defaultPriority [
	^ 75
]

{ #category : #initialize }
LcsModuleConfigurationSlot >> initialize [
	super initialize.
	self slotName: 'configuration'
]

{ #category : #initialize }
LcsModuleConfigurationSlot >> initializeOn: aConfigurationClass [ 
	self addSlotType: aConfigurationClass
]
