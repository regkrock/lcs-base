Class {
	#name : #LxxPrototypePerson,
	#superclass : #LcsDomainObject,
	#instVars : [
		'dateOfBirth',
		'lastName'
	],
	#category : #'Lcs-PrototypeSystem-Base'
}

{ #category : #'slot definitions' }
LxxPrototypePerson class >> dateOfBirthSlotDefinition [
	<slotDefinition>
	^ LcsDateOfBirthSlot new
]

{ #category : #'slot definitions' }
LxxPrototypePerson class >> lastNameSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'lastName';
		yourself
]

{ #category : #'slot definitions' }
LxxPrototypePerson class >> parentSlotDefinition [
	<slotDefinition>
	^ LcsGlobalCollectionReferenceSlot new
		slotName: 'parent';
		collectionSlotModuleName: LxxPrototypeSystem moduleName;
		addSlotType: LxxPrototypePersons;
		collectionSlotName: 'persons';
		yourself
]

{ #category : #accessing }
LxxPrototypePerson >> dateOfBirth [
	^ self slotVarNamed: 'dateOfBirth'
]

{ #category : #accessing }
LxxPrototypePerson >> dateOfBirth: anObject [
	self slotVarNamed: 'dateOfBirth' put: anObject
]

{ #category : #accessing }
LxxPrototypePerson >> lastName [
	^ self slotVarNamed: 'lastName'
]

{ #category : #accessing }
LxxPrototypePerson >> lastName: anObject [
	self slotVarNamed: 'lastName' put: anObject
]
