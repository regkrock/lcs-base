Class {
	#name : #LcsLegalEntitiesModule,
	#superclass : #LcsModule,
	#instVars : [
		'persons',
		'organizations'
	],
	#category : #'Lcs-LegalEntities'
}

{ #category : #'slot definition' }
LcsLegalEntitiesModule class >> moduleConfigurationClass [
	^ LcsLegalEntitiesModuleConfiguration
]

{ #category : #configuration }
LcsLegalEntitiesModule class >> moduleName [
	^ 'Legal Entities Module'
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

{ #category : #configur }
LcsLegalEntitiesModule class >> owningModules [
	<owningModule: 'LcsMainSystem'>
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
	^ self getValueOfSlotNamed: 'organizations'
]

{ #category : #accessing }
LcsLegalEntitiesModule >> organizations: anObject [
	self setValueOfSlotNamed: 'organizations' to: anObject
]

{ #category : #accessing }
LcsLegalEntitiesModule >> persons [
	^ self getValueOfSlotNamed: 'persons'
]

{ #category : #accessing }
LcsLegalEntitiesModule >> persons: anObject [
	self setValueOfSlotNamed: 'persons' to: anObject
]
