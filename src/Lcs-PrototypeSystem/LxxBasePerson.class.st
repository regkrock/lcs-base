Class {
	#name : #LxxBasePerson,
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
LxxBasePerson class >> dateOfBirthSlotDefinition [
	<slotDefinition>
	^ LcsDateOfBirthSlot new
]

{ #category : #'slot definition' }
LxxBasePerson class >> firstNameSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'firstName';
		yourself
]

{ #category : #'slot definitions' }
LxxBasePerson class >> lastNameSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'lastName';
		yourself
]

{ #category : #'slot definition' }
LxxBasePerson class >> middleNameSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'middleName';
		yourself
]

{ #category : #accessing }
LxxBasePerson >> dateOfBirth [
	^ self slotVarNamed: 'dateOfBirth'
]

{ #category : #accessing }
LxxBasePerson >> dateOfBirth: anObject [
	self slotVarNamed: 'dateOfBirth' put: anObject
]

{ #category : #accessing }
LxxBasePerson >> firstName [
	^ self slotVarNamed: 'firstName'
]

{ #category : #accessing }
LxxBasePerson >> firstName: anObject [
	self slotVarNamed: 'firstName' to: anObject
]

{ #category : #accessing }
LxxBasePerson >> lastName [
	^ self slotVarNamed: 'lastName'
]

{ #category : #accessing }
LxxBasePerson >> lastName: anObject [
	self slotVarNamed: 'lastName' put: anObject
]

{ #category : #accessing }
LxxBasePerson >> middleName [
	^ self slotVarNamed: 'middleName'
]

{ #category : #accessing }
LxxBasePerson >> middleName: anObject [
	self slotVarNamed: 'middleName' put: anObject
]
