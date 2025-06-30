Class {
	#name : #LcsGeographyModule,
	#superclass : #LcsModule,
	#instVars : [
		'countries'
	],
	#category : #'Lcs-Geography-Domain'
}

{ #category : #'slot definitions' }
LcsGeographyModule class >> countriesSlotDefinition [
	<slotDefinition>
	^ LcsGlobalCollectionSlot new
		slotName: 'countries';
		addSlotType: LcsCountries;
		addCollectionMemberType: LcsCountry;
		yourself
]

{ #category : #configuration }
LcsGeographyModule class >> defaultModuleName [
	^ 'Geography Module'
]

{ #category : #'slot definitions' }
LcsGeographyModule class >> moduleConfigurationClass [
	^ LcsGeographyModuleConfiguration
]

{ #category : #configuration }
LcsGeographyModule class >> owningModules [
	<owningModule: 'LcsMainSystem'>
	<owningModule: 'LcsWarRabbitLibrary'>
]

{ #category : #accessing }
LcsGeographyModule >> countries [
	^ self slotVarNamed: 'countries'
]

{ #category : #accessing }
LcsGeographyModule >> countries: anObject [
	self slotVarNamed: 'countries' put: anObject
]
