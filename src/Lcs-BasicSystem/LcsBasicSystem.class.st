Class {
	#name : 'LcsBasicSystem',
	#superclass : 'LcsSystem',
	#category : 'Lcs-BasicSystem',
	#package : 'Lcs-BasicSystem'
}

{ #category : 'slot definitions' }
LcsBasicSystem class >> configurationSlotDefinition [
	<accessorSlotDefinition>
	^ (self configurationSlotDefinitionOn: self moduleConfigurationClass) yourself
]

{ #category : 'configuration' }
LcsBasicSystem class >> defaultModuleName [
	^ 'Basic System'
]

{ #category : 'configuration' }
LcsBasicSystem class >> moduleConfigurationClass [
	^ LcsBasicSystemConfiguration
]

{ #category : 'slot model' }
LcsBasicSystem >> systemDomainClasses [
	| collection |
	collection := super systemDomainClasses.
	self addClasses: self class package definedClasses to: collection.
	^ collection
]
