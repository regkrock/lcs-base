Class {
	#name : 'LcsDemoSystem',
	#superclass : 'LcsSystem',
	#category : 'Lcs-DemoSystem-Core',
	#package : 'Lcs-DemoSystem',
	#tag : 'Core'
}

{ #category : 'slot definitions' }
LcsDemoSystem class >> configurationSlotDefinition [
	<accessorSlotDefinition>
	^ self configurationSlotDefinitionOn: self moduleConfigurationClass
]

{ #category : 'configuration' }
LcsDemoSystem class >> defaultModuleName [
	^ 'Demo System'
]

{ #category : 'configuration' }
LcsDemoSystem class >> moduleConfigurationClass [
	^ LcsDemoSystemConfiguration
]

{ #category : 'testing' }
LcsDemoSystem >> isDemoSystem [
	^ true
]

{ #category : 'iniitialize - load data' }
LcsDemoSystem >> loadData [
	super loadData.
	self applyChanges
]

{ #category : 'slot model' }
LcsDemoSystem >> systemDomainClasses [
	| collection |
	collection := super systemDomainClasses.
	self addClasses: self class package definedClasses to: collection.
	^ collection
]
