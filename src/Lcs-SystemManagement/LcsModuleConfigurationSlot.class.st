Class {
	#name : #LcsModuleConfigurationSlot,
	#superclass : #LcsCompositeSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #'instance creation' }
LcsModuleConfigurationSlot class >> newOn: aConfigurationClass [
	^ self new
		initializeOn: aConfigurationClass
		yourself
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
