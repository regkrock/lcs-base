Class {
	#name : #LcsModuleConfigurationSlotDefinition,
	#superclass : #LcsCompositeSlotDefinition,
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #accessing }
LcsModuleConfigurationSlotDefinition class >> newOn: aConfigurationClass [
	^ self new
		initializeOn: aConfigurationClass
		yourself
]

{ #category : #accessing }
LcsModuleConfigurationSlotDefinition >> initialize [
	super initialize.
	self slotName: 'configuration'
]

{ #category : #accessing }
LcsModuleConfigurationSlotDefinition >> initializeOn: aConfigurationClass [ 
	self addSlotType: aConfigurationClass
]
