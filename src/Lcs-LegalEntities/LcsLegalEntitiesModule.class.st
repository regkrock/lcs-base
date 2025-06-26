Class {
	#name : #LcsLegalEntitiesModule,
	#superclass : #LcsModule,
	#instVars : [
		'persons',
		'organizations',
		'genders',
		'titles'
	],
	#category : #'Lcs-LegalEntities'
}

{ #category : #configuration }
LcsLegalEntitiesModule class >> defaultModuleName [
	^ 'Legal Entities Module'
]

{ #category : #'slot definition' }
LcsLegalEntitiesModule class >> gendersSlotDefinition [
	<slotDefinition>
	^ LcsSingletonValueObjectsGlobalCollectionSlot new
		slotName: 'genders';
		addSlotType: LcsGenders;
		valueObjectSuperclass: LcsGender;
		yourself
]

{ #category : #'slot definitions' }
LcsLegalEntitiesModule class >> moduleConfigurationClass [
	^ LcsLegalEntitiesModuleConfiguration
]

{ #category : #'slot definitions' }
LcsLegalEntitiesModule class >> organizationsSlotDefinition [
	<slotDefinition>
	^ LcsGlobalCollectionSlot new
		slotName: 'organizations';
		addSlotType: LcsOrganizations;
		addCollectionMemberType: LcsCountry;
		yourself
]

{ #category : #configuration }
LcsLegalEntitiesModule class >> owningModules [
	<owningModule: 'LcsMainSystem'>
	<owningModule: 'LcsWarRabbitLibrary'>
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

{ #category : #'slot definition' }
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
LcsLegalEntitiesModule >> titles [
	^ self slotVarNamed: 'titles'
]

{ #category : #accessing }
LcsLegalEntitiesModule >> titles: anObject [
	self slotVarNamed: 'titles' put: anObject
]
