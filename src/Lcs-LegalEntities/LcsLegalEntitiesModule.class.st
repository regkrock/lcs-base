Class {
	#name : #LcsLegalEntitiesModule,
	#superclass : #LcsModule,
	#instVars : [
		'persons',
		'organizations',
		'genders',
		'titles',
		'phoneNumbers',
		'phoneNumberTypes',
		'emailAddresses',
		'emailAddressTypes'
	],
	#category : #'Lcs-LegalEntities'
}

{ #category : #'slot definitions' }
LcsLegalEntitiesModule class >> configurationSlotDefinition [
	<slotDefinition>
	^ self configurationSlotDefinitionOn: self moduleConfigurationClass
]

{ #category : #configuration }
LcsLegalEntitiesModule class >> defaultModuleName [
	^ 'Legal Entities Module'
]

{ #category : #'slot definitions' }
LcsLegalEntitiesModule class >> emailAddressTypesSlotDefinition [
	<slotDefinition>
	^ LcsValueObjectsGlobalCollectionSlot new
		slotTypes: (OrderedCollection with: LcsEmailAddressTypes);
		collectionMemberTypes: (OrderedCollection with: LcsEmailAddressType);
		slotName: 'emailAddressTypes';
		loaderClass: LcsEmailAddressTypesLoader;
		priority: 10;
		yourself
]

{ #category : #'slot definitions' }
LcsLegalEntitiesModule class >> emailAddressesSlotDefinition [
	<slotDefinition>
	^ LcsGlobalCollectionSlot new
		slotTypes: (OrderedCollection with: LcsEmailAddresses);
		collectionMemberTypes: (OrderedCollection with: LcsEmailAddress);
		slotName: 'emailAddresses';
		yourself
]

{ #category : #'slot definitions' }
LcsLegalEntitiesModule class >> gendersSlotDefinition [
	<slotDefinition>
	^ LcsSingletonValueObjectsGlobalCollectionSlot new
		slotName: 'genders';
		addSlotType: LcsGenders;
		valueObjectSuperclass: LcsGender;
		priority: 10;
		yourself
]

{ #category : #configuration }
LcsLegalEntitiesModule class >> moduleConfigurationClass [
	^ LcsLegalEntitiesModuleConfiguration
]

{ #category : #'slot definitions' }
LcsLegalEntitiesModule class >> organizationsSlotDefinition [
	<slotDefinition>
	^ LcsGlobalCollectionSlot new
		slotName: 'organizations';
		addSlotType: LcsOrganizations;
		addCollectionMemberType: LcsOrganization;
		yourself
]

{ #category : #configuration }
LcsLegalEntitiesModule class >> owningModules [
	<owningModule: 'LcsDemoSystem' priority: 10>
	<owningModule: 'LcsWarRabbitLibrary' priority: 10>
	<owningModule: 'LcsSailingClub' priority: 10>
]

{ #category : #'slot definitions' }
LcsLegalEntitiesModule class >> personsSlotDefinition [
	<slotDefinition>
	^ LcsGlobalCollectionSlot new
		slotName: 'persons';
		priority: 60;
		addSlotType: LcsPersons;
		addCollectionMemberType: LcsPerson;
		yourself
]

{ #category : #'slot definitions' }
LcsLegalEntitiesModule class >> phoneNumberTypesSlotDefinition [
	<slotDefinition>
	^ LcsValueObjectsGlobalCollectionSlot new
		slotTypes: (OrderedCollection with: LcsPhoneNumberTypes);
		collectionMemberTypes: (OrderedCollection with: LcsPhoneNumberType);
		slotName: 'phoneNumberTypes';
		priority: 10;
		loaderClass: LcsPhoneNumberTypesLoader;
		yourself
]

{ #category : #'slot definitions' }
LcsLegalEntitiesModule class >> phoneNumbersSlotDefinition [
	<slotDefinition>
	^ LcsGlobalCollectionSlot new
		slotTypes: (OrderedCollection with: LcsPhoneNumbers);
		collectionMemberTypes: (OrderedCollection with: LcsPhoneNumber);
		slotName: 'phoneNumbers';
		yourself
]

{ #category : #'slot definitions' }
LcsLegalEntitiesModule class >> titlesSlotDefinition [
	<slotDefinition>
	^ LcsValueObjectsGlobalCollectionSlot new
		slotName: 'titles';
		addSlotType: LcsTitles;
		collectionClass: IdentitySet;
		loaderClass: LcsTitlesLoader;
		priority: 10;
		yourself
]

{ #category : #accessing }
LcsLegalEntitiesModule >> emailAddressTypes [
	^ self slotVarNamed: 'emailAddressTypes'
]

{ #category : #accessing }
LcsLegalEntitiesModule >> emailAddressTypes: anObject [
	self slotVarNamed: 'emailAddressTypes' put: anObject
]

{ #category : #accessing }
LcsLegalEntitiesModule >> emailAddresses [
	^ self slotVarNamed: 'emailAddresses'
]

{ #category : #accessing }
LcsLegalEntitiesModule >> emailAddresses: anObject [
	self slotVarNamed: 'emailAddresses' put: anObject
]

{ #category : #accessing }
LcsLegalEntitiesModule >> genders [
	^ self slotVarNamed: 'genders'
]

{ #category : #accessing }
LcsLegalEntitiesModule >> genders: anObject [
	self slotVarNamed: 'genders' put: anObject
]

{ #category : #accessing }
LcsLegalEntitiesModule >> organizations [
	^ self slotVarNamed: 'organizations'
]

{ #category : #accessing }
LcsLegalEntitiesModule >> organizations: anObject [
	self slotVarNamed: 'organizations' put: anObject
]

{ #category : #accessing }
LcsLegalEntitiesModule >> persons [
	^ self slotVarNamed: 'persons'
]

{ #category : #accessing }
LcsLegalEntitiesModule >> persons: anObject [
	self slotVarNamed: 'persons' put: anObject
]

{ #category : #accessing }
LcsLegalEntitiesModule >> phoneNumberTypes [
	^ self slotVarNamed: 'phoneNumberTypes'
]

{ #category : #accessing }
LcsLegalEntitiesModule >> phoneNumberTypes: anObject [
	self slotVarNamed: 'phoneNumberTypes' put: anObject
]

{ #category : #accessing }
LcsLegalEntitiesModule >> phoneNumbers [
	^ self slotVarNamed: 'phoneNumbers'
]

{ #category : #accessing }
LcsLegalEntitiesModule >> phoneNumbers: anObject [
	self slotVarNamed: 'phoneNumbers' put: anObject
]

{ #category : #accessing }
LcsLegalEntitiesModule >> titles [
	^ self slotVarNamed: 'titles'
]

{ #category : #accessing }
LcsLegalEntitiesModule >> titles: anObject [
	self slotVarNamed: 'titles' put: anObject
]
