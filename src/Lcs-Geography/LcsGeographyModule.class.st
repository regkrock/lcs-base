Class {
	#name : #LcsGeographyModule,
	#superclass : #LcsModule,
	#instVars : [
		'countries'
	],
	#category : #'Lcs-Geography'
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

{ #category : #'slot definitions' }
LcsGeographyModule class >> moduleConfigurationClass [
	^ LcsGeographyModuleConfiguration
]

{ #category : #configuration }
LcsGeographyModule class >> moduleName [
	^ 'Geography Module'
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
