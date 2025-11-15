Class {
	#name : #LcsCalendarModule,
	#superclass : #LcsModule,
	#category : #'Lcs-Calendar-Core'
}

{ #category : #'slot definitions' }
LcsCalendarModule class >> configurationSlotDefinition [
	<slotDefinition>
	^ self configurationSlotDefinitionOn: self moduleConfigurationClass
]

{ #category : #configuration }
LcsCalendarModule class >> defaultModuleName [
	^ 'Calendar Module'
]

{ #category : #'generated method' }
LcsCalendarModule class >> moduleConfigurationClass [
	^ LcsCalendarModuleConfiguration
]

{ #category : #configuration }
LcsCalendarModule class >> owningModules [
	<owningModule: 'LcsSailingClubSystem' priority: 5>
]
