Class {
	#name : #LcsBasePerson,
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
LcsBasePerson class >> dateOfBirthSlotDefinition [
	<slotDefinition>
	^ LcsDateOfBirthSlot new
]

{ #category : #'slot definitions' }
LcsBasePerson class >> firstNameSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'firstName';
		yourself
]

{ #category : #'slot definitions' }
LcsBasePerson class >> middleNamesSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'middleNames';
		yourself
]

{ #category : #'slot definitions' }
LcsBasePerson class >> surnameSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'surname';
		yourself
]

{ #category : #accessing }
LcsBasePerson >> dateOfBirth [
	^ self slotVarNamed: 'dateOfBirth'
]

{ #category : #accessing }
LcsBasePerson >> dateOfBirth: anObject [
	self slotVarNamed: 'dateOfBirth' put: anObject
]

{ #category : #accessing }
LcsBasePerson >> firstName [
	^ self slotVarNamed: 'firstName'
]

{ #category : #accessing }
LcsBasePerson >> firstName: anObject [
	self slotVarNamed: 'firstName' put: anObject
]

{ #category : #accessing }
LcsBasePerson >> middleNames [
	^ self slotVarNamed: 'middleNames'
]

{ #category : #accessing }
LcsBasePerson >> middleNames: anObject [
	self slotVarNamed: 'middleNames' put: anObject
]

{ #category : #accessing }
LcsBasePerson >> surname [
	^ self slotVarNamed: 'surname'
]

{ #category : #accessing }
LcsBasePerson >> surname: anObject [
	self slotVarNamed: 'surname' put: anObject
]
