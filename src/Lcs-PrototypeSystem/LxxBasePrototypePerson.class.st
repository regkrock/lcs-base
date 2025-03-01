Class {
	#name : #LxxBasePrototypePerson,
	#superclass : #LcsDomainObject,
	#instVars : [
		'dateOfBirth',
		'lastName'
	],
	#category : #'Lcs-PrototypeSystem-Base'
}

{ #category : #'slot definitions' }
LxxBasePrototypePerson class >> dateOfBirthSlotDefinition [
	<slotDefinition>
	^ LcsDateOfBirthSlot new
]

{ #category : #'slot definitions' }
LxxBasePrototypePerson class >> lastNameSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'lastName';
		yourself
]

{ #category : #accessing }
LxxBasePrototypePerson >> dateOfBirth [
	^ self slotVarNamed: 'dateOfBirth'
]

{ #category : #accessing }
LxxBasePrototypePerson >> dateOfBirth: anObject [
	self slotVarNamed: 'dateOfBirth' put: anObject
]

{ #category : #accessing }
LxxBasePrototypePerson >> lastName [
	^ self slotVarNamed: 'lastName'
]

{ #category : #accessing }
LxxBasePrototypePerson >> lastName: anObject [
	self slotVarNamed: 'lastName' put: anObject
]
