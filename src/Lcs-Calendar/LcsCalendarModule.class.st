Class {
	#name : 'LcsCalendarModule',
	#superclass : 'LcsModule',
	#category : 'Lcs-Calendar-Core',
	#package : 'Lcs-Calendar',
	#tag : 'Core'
}

{ #category : 'slot definitions' }
LcsCalendarModule class >> configurationSlotDefinition [
	<accessorSlotDefinition>
	^ self configurationSlotDefinitionOn: self moduleConfigurationClass
]

{ #category : 'configuration' }
LcsCalendarModule class >> defaultModuleName [
	^ 'Calendar Module'
]

{ #category : 'generated method' }
LcsCalendarModule class >> moduleConfigurationClass [
	^ LcsCalendarModuleConfiguration
]

{ #category : 'configuration' }
LcsCalendarModule class >> owningModules [
	<owningModule: 'LcsSailingClubSystem' priority: 15>
	<owningModule: 'LcsDemoSystem' priority: 15>
]
