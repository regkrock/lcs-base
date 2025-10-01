Class {
	#name : #LcsGeographyModule,
	#superclass : #LcsModule,
	#instVars : [
		'countries',
		'addressTypes'
	],
	#category : #'Lcs-Geography-Domain'
}

{ #category : #'slot definitions' }
LcsGeographyModule class >> addressTypesSlotDefinition [
	<slotDefinition>
	^ LcsValueObjectsGlobalCollectionSlot new
		slotTypes: (OrderedCollection with: LcsAddressTypes);
		collectionMemberTypes: (OrderedCollection with: LcsAddressType);
		slotName: 'addressTypes';
		loaderClass: LcsAddressTypesLoader;
		yourself
]

{ #category : #'slot definitions' }
LcsGeographyModule class >> configurationSlotDefinition [
	<slotDefinition>
	^ LcsModuleConfigurationSlot newOn: self moduleConfigurationClass
]

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

{ #category : #configuration }
LcsGeographyModule class >> moduleConfigurationClass [
	^ LcsGeographyModuleConfiguration
]

{ #category : #configuration }
LcsGeographyModule class >> owningModules [
	<owningModule: 'LcsMainSystem'>
	<owningModule: 'LcsWarRabbitLibrary'>
]

{ #category : #accessing }
LcsGeographyModule >> addressTypes [
	^ self slotVarNamed: 'addressTypes'
]

{ #category : #accessing }
LcsGeographyModule >> addressTypes: anObject [
	self slotVarNamed: 'addressTypes' put: anObject
]

{ #category : #accessing }
LcsGeographyModule >> countries [
	^ self slotVarNamed: 'countries'
]

{ #category : #accessing }
LcsGeographyModule >> countries: anObject [
	self slotVarNamed: 'countries' put: anObject
]
