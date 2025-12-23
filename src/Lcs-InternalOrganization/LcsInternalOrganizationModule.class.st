Class {
	#name : 'LcsInternalOrganizationModule',
	#superclass : 'LcsModule',
	#category : 'Lcs-InternalOrganization-Core',
	#package : 'Lcs-InternalOrganization',
	#tag : 'Core'
}

{ #category : 'slot definitions' }
LcsInternalOrganizationModule class >> configurationSlotDefinition [
	<accessorSlotDefinition>
	^ self configurationSlotDefinitionOn: self moduleConfigurationClass
]

{ #category : 'configuration' }
LcsInternalOrganizationModule class >> defaultModuleName [
	^ 'Internal Organization Module'
]

{ #category : 'generated method' }
LcsInternalOrganizationModule class >> moduleConfigurationClass [
	^ LcsInternalOrganizationModuleConfiguration
]

{ #category : 'configuration' }
LcsInternalOrganizationModule class >> owningModules [
	<owningModule: 'LcsDemoSystem' priority: 15>
	<owningModule: 'LcsSailingClubSystem' priority: 15>
]
