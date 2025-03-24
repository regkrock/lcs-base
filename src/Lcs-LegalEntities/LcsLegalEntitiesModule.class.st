Class {
	#name : #LcsLegalEntitiesModule,
	#superclass : #LcsModule,
	#instVars : [
		'persons',
		'organizations'
	],
	#category : #'Lcs-LegalEntities'
}

{ #category : #configuration }
LcsLegalEntitiesModule class >> defaultModuleName [
	^ 'Legal Entities Module'
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
		addSlotType: LcsPersons;
		addCollectionMemberType: LcsPerson;
		yourself
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
