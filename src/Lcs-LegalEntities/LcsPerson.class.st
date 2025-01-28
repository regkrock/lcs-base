Class {
	#name : #LcsPerson,
	#superclass : #LcsLegalEntity,
	#instVars : [
		'dateOfBirth',
		'firstName',
		'surname',
		'middleNames'
	],
	#category : #'Lcs-LegalEntities'
}

{ #category : #'slot definitions' }
LcsPerson class >> dateOfBirthSlotDefinition [
	<slotDefinition>
	^ LcsDateOfBirthSlot new
]

{ #category : #'slot definition' }
LcsPerson class >> firstNameSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'firstName';
		yourself
]

{ #category : #'slot definition' }
LcsPerson class >> middleNamesSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'middleNames';
		yourself
]

{ #category : #'slot definitions' }
LcsPerson class >> parentSlotDefinition [
	<slotDefinition>
	^ LcsGlobalCollectionReferenceSlot new
		slotName: 'parent';
		collectionSlotModuleName: LcsLegalEntitiesModule moduleName;
		collectionSlotName: 'persons';
		yourself
]

{ #category : #'slot definition' }
LcsPerson class >> surnameSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'surname';
		yourself
]

{ #category : #accessing }
LcsPerson >> dateOfBirth [
	^ self slotVarNamed: 'dateOfBirth'
]

{ #category : #accessing }
LcsPerson >> dateOfBirth: anObject [
	self slotVarNamed: 'dateOfBirth' put: anObject
]

{ #category : #accessing }
LcsPerson >> firstName [
	^ self slotVarNamed: 'firstName'
]

{ #category : #accessing }
LcsPerson >> firstName: anObject [
	self slotVarNamed: 'firstName' put: anObject
]

{ #category : #accessing }
LcsPerson >> middleNames [
	^ self slotVarNamed: 'middleNames'
]

{ #category : #accessing }
LcsPerson >> middleNames: anObject [
	self slotVarNamed: 'middleNames' put: anObject
]

{ #category : #accessing }
LcsPerson >> surname [
	^ self slotVarNamed: 'surname'
]

{ #category : #accessing }
LcsPerson >> surname: anObject [
	self slotVarNamed: 'surname' put: anObject
]
