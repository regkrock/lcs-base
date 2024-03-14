Class {
	#name : #LcsLegalEntitiesModule,
	#superclass : #LcsModule,
	#instVars : [
		'persons',
		'organizations'
	],
	#category : #'Lcs-LegalEntities'
}

{ #category : #accessing }
LcsLegalEntitiesModule class >> moduleName [
	^ 'Legal Entities Module'
]

{ #category : #'slot definitions' }
LcsLegalEntitiesModule class >> organizationsSlotDefinition [
	<slotDefinition>
	^ LcsGlobalCollectionSlotDefinition new
		slotName: 'organizations';
		addSlotType: LcsSmalltalkConfiguration identitySetClass
		yourself
]

{ #category : #'slot definitions' }
LcsLegalEntitiesModule class >> personsSlotDefinition [
	<slotDefinition>
	^ LcsGlobalCollectionSlotDefinition new
		slotName: 'persons';
		addSlotType: LcsSmalltalkConfiguration identitySetClass
		yourself
]

{ #category : #accessing }
LcsLegalEntitiesModule >> configurationSlotDefinition [
	<slotDefinition>
	^ LcsModuleConfigurationSlotDefinition newOn: LcsLegalEntitiesModuleConfiguration
]

{ #category : #accessing }
LcsLegalEntitiesModule >> organizations [
	^ organizations
]

{ #category : #accessing }
LcsLegalEntitiesModule >> organizations: anObject [
	organizations := anObject
]

{ #category : #accessing }
LcsLegalEntitiesModule >> persons [
	^ persons
]

{ #category : #accessing }
LcsLegalEntitiesModule >> persons: anObject [
	persons := anObject
]
