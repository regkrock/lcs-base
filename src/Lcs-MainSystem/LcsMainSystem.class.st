Class {
	#name : #LcsMainSystem,
	#superclass : #LcsSystem,
	#category : #'Lcs-MainSystem'
}

{ #category : #'slot definitions' }
LcsMainSystem class >> configurationSlotDefinition [
	<slotDefinition>
	^ LcsModuleConfigurationSlot newOn: self moduleConfigurationClass
]

{ #category : #configuration }
LcsMainSystem class >> moduleConfigurationClass [
	^ LcsMainSystemConfiguration
]

{ #category : #'as yet unclassified' }
LcsMainSystem >> isMainSystem [
	^ true
]

{ #category : #'iniitialize - load data' }
LcsMainSystem >> loadData [
	super loadData.
	LcsCountryLoader new load.
	self applyChanges
]

{ #category : #'slot model' }
LcsMainSystem >> systemDomainClasses [
	| collection |
	collection := super systemDomainClasses.
	self addClasses: self class package classes to: collection.
	^ collection
]
