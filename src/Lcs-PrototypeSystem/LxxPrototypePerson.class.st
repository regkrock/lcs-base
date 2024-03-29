Class {
	#name : #LxxPrototypePerson,
	#superclass : #LcsDomainObject,
	#instVars : [
		'dateOfBirth'
	],
	#category : #'Lcs-PrototypeSystem'
}

{ #category : #'slot definitions' }
LxxPrototypePerson class >> dateOfBirthSlotDefinition [
	<slotDefinition>
	^ LcsDateOfBirthSlotDefinition new
]

{ #category : #'slot definitions' }
LxxPrototypePerson class >> parentSlotDefinition [
	<slotDefinition>
	^ LcsGlobalCollectionReferenceSlotDefinition new
		slotName: 'parent';
		moduleName: LxxPrototype1Module moduleName;
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
