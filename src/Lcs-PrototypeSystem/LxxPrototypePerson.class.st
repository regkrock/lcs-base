Class {
	#name : #LxxPrototypePerson,
	#superclass : #LcsDomainObject,
	#instVars : [
		'dateOfBirth',
		'lastName'
	],
	#category : #'Lcs-PrototypeSystem'
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
		collectionSlotName: 'persons';
		yourself
]

{ #category : #accessing }
LxxPrototypePerson >> dateOfBirth [
	^ self getValueOfSlotNamed: 'dateOfBirth'
]

{ #category : #accessing }
LxxPrototypePerson >> dateOfBirth: anObject [
	self setValueOfSlotNamed: 'dateOfBirth' to: anObject
]

{ #category : #accessing }
LxxPrototypePerson >> lastName [
	^ self getValueOfSlotNamed: 'lastName'
]

{ #category : #accessing }
LxxPrototypePerson >> lastName: anObject [
	self setValueOfSlotNamed: 'lastName' to: anObject
]
