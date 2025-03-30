Class {
	#name : #LxxBasePrototypePerson,
	#superclass : #LcsDomainObject,
	#instVars : [
		'dateOfBirth',
		'lastName',
		'firstName',
		'middleName'
	],
	#category : #'Lcs-PrototypeSystem-Base'
}

{ #category : #'slot definitions' }
LxxBasePrototypePerson class >> dateOfBirthSlotDefinition [
	<slotDefinition>
	^ LcsDateOfBirthSlot new
]

{ #category : #'slot definition' }
LxxBasePrototypePerson class >> firstNameSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'firstName';
		yourself
]

{ #category : #'slot definitions' }
LxxBasePrototypePerson class >> lastNameSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'lastName';
		yourself
]

{ #category : #'slot definition' }
LxxBasePrototypePerson class >> middleNameSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'middleName';
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
LxxBasePrototypePerson >> firstName [
	^ self getValueOfSlotNamed: 'firstName'
]

{ #category : #accessing }
LxxBasePrototypePerson >> firstName: anObject [
	self setValueOfSlotNamed: 'firstName' to: anObject
]

{ #category : #accessing }
LxxBasePrototypePerson >> lastName [
	^ self slotVarNamed: 'lastName'
]

{ #category : #accessing }
LxxBasePrototypePerson >> lastName: anObject [
	self slotVarNamed: 'lastName' put: anObject
]

{ #category : #accessing }
LxxBasePrototypePerson >> middleName [
	^ self getValueOfSlotNamed: 'middleName'
]

{ #category : #accessing }
LxxBasePrototypePerson >> middleName: anObject [
	self setValueOfSlotNamed: 'middleName' to: anObject
]
