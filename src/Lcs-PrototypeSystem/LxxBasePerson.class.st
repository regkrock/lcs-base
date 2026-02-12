Class {
	#name : 'LxxBasePerson',
	#superclass : 'LcsDomainObject',
	#instVars : [
		'dateOfBirth',
		'lastName',
		'firstName',
		'middleName'
	],
	#category : 'Lcs-PrototypeSystem-Core',
	#package : 'Lcs-PrototypeSystem',
	#tag : 'Core'
}

{ #category : 'slot definitions' }
LxxBasePerson class >> dateOfBirthSlotDefinition [
	<accessorSlotDefinition>
	^ LcsDateOfBirthSlot new
]

{ #category : 'slot definition' }
LxxBasePerson class >> firstNameSlotDefinition [
	<accessorSlotDefinition>
	^ LcsStringSlot new
		slotName: 'firstName';
		yourself
]

{ #category : 'slot definitions' }
LxxBasePerson class >> lastNameSlotDefinition [
	<accessorSlotDefinition>
	^ LcsStringSlot new
		slotName: 'lastName';
		yourself
]

{ #category : 'slot definition' }
LxxBasePerson class >> middleNameSlotDefinition [
	<accessorSlotDefinition>
	^ LcsStringSlot new
		slotName: 'middleName';
		yourself
]

{ #category : 'cal' }
LxxBasePerson >> _age [
	| today birthDate |
	today := Date today .
	birthDate := self dateOfBirth.
	^ (today monthIndex > birthDate monthIndex or: [ 
			today monthIndex = birthDate monthIndex and: [ today day >= birthDate day ] ])
		ifTrue: [ today year - birthDate year ]
		ifFalse: [  today year - birthDate year - 1] 
 
]

{ #category : 'accessing' }
LxxBasePerson >> dateOfBirth [
	^ self slotVarNamed: 'dateOfBirth'
]

{ #category : 'accessing' }
LxxBasePerson >> dateOfBirth: anObject [
	self slotVarNamed: 'dateOfBirth' put: anObject
]

{ #category : 'accessing' }
LxxBasePerson >> firstName [
	^ self slotVarNamed: 'firstName'
]

{ #category : 'accessing' }
LxxBasePerson >> firstName: anObject [
	self slotVarNamed: 'firstName' put: anObject
]

{ #category : 'accessing' }
LxxBasePerson >> lastName [
	^ self slotVarNamed: 'lastName'
]

{ #category : 'accessing' }
LxxBasePerson >> lastName: anObject [
	self slotVarNamed: 'lastName' put: anObject
]

{ #category : 'accessing' }
LxxBasePerson >> middleName [
	^ self slotVarNamed: 'middleName'
]

{ #category : 'accessing' }
LxxBasePerson >> middleName: anObject [
	self slotVarNamed: 'middleName' put: anObject
]
