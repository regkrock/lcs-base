Class {
	#name : #LxxPerson,
	#superclass : #LcsDomainObject,
	#instVars : [
		'dateOfBirth'
	],
	#category : #'Lcs-PrototypeSystem'
}

{ #category : #'slot definitions' }
LxxPerson class >> dateOfBirthSlotDefinition [
	<slotDefinition>
	^ LcsDateOfBirthSlotDefinition new
]

{ #category : #accessing }
LxxPerson >> dateOfBirth [
	^ self getValueOfSlotNamed: 'dateOfBirth'
]

{ #category : #accessing }
LxxPerson >> dateOfBirth: anObject [
	self setValueOfSlotNamed: 'dateOfBirth' to: anObject
]

{ #category : #accessing }
LxxPerson >> parentSlotDefinition [
	<slotDefinition>
	^LcsGlobalCollectionReferenceSlotDefinition new
		slotName: 'parent';
		moduleName: LxxPrototype1Module moduleName;
		collectionSlotName: 'persons';
		yourself
]
