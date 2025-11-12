Class {
	#name : #LcsGeographyModule,
	#superclass : #LcsModule,
	#instVars : [
		'countries',
		'addressTypes',
		'addresses'
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
		priority: 20;
		yourself
]

{ #category : #'slot definitions' }
LcsGeographyModule class >> addressesSlotDefinition [
	<slotDefinition>
	^ LcsGlobalCollectionSlot new
		slotTypes: (OrderedCollection with: LcsAddresses);
		collectionMemberTypes: (OrderedCollection with: LcsAddress);
		slotName: 'addresses';
		yourself
]

{ #category : #'slot definitions' }
LcsGeographyModule class >> configurationSlotDefinition [
	<slotDefinition>
	^ (self configurationSlotDefinitionOn: self moduleConfigurationClass)
			priority: 5;
			yourself
]

{ #category : #'slot definitions' }
LcsGeographyModule class >> countriesSlotDefinition [
	<slotDefinition>
	^ LcsGlobalCollectionSlot new
		slotName: 'countries';
		addSlotType: LcsCountries;
		addCollectionMemberType: LcsCountry;
		loaderClass: LcsCountriesLoader;
		priority: 4;
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
	<owningModule: 'LcsDemoSystem' priority: 5>
	<owningModule: 'LcsWarRabbitLibrary' priority: 5>
	<owningModule: 'LcsSailingClub' priority: 5>
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
LcsGeographyModule >> addresses [
	^ self slotVarNamed: 'addresses'
]

{ #category : #accessing }
LcsGeographyModule >> addresses: anObject [
	self slotVarNamed: 'addresses' put: anObject
]

{ #category : #accessing }
LcsGeographyModule >> countries [
	^ self slotVarNamed: 'countries'
]

{ #category : #accessing }
LcsGeographyModule >> countries: anObject [
	self slotVarNamed: 'countries' put: anObject
]
