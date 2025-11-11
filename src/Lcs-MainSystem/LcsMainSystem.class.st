Class {
	#name : #LcsMainSystem,
	#superclass : #LcsSystem,
	#category : #'Lcs-MainSystem-Core'
}

{ #category : #'slot definitions' }
LcsMainSystem class >> configurationSlotDefinition [
	<slotDefinition>
	^ super configurationSlotDefinition
]

{ #category : #configuration }
LcsMainSystem class >> defaultModuleName [
	^ 'System'
]

{ #category : #configuration }
LcsMainSystem class >> moduleConfigurationClass [
	^ LcsMainSystemConfiguration
]

{ #category : #testing }
LcsMainSystem >> isMainSystem [
	^ true
]

{ #category : #'iniitialize - load data' }
LcsMainSystem >> loadData [
	super loadData.
	"LcsCountryLoader new load."
	self applyChanges
]

{ #category : #'slot model' }
LcsMainSystem >> systemDomainClasses [
	| collection |
	collection := super systemDomainClasses.
	self addClasses: self class package definedClasses to: collection.
	^ collection
]
