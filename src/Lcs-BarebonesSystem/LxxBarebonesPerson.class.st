Class {
	#name : #LxxBarebonesPerson,
	#superclass : #LcsDomainObject,
	#instVars : [
		'dateOfBirth'
	],
	#category : #'Lcs-BarebonesSystem'
}

{ #category : #'slot definitions' }
LxxBarebonesPerson class >> dateOfBirthSlotDefinition [
	<slotDefinition>
	^ LcsDateOfBirthSlotDefinition new
]

{ #category : #'slot definitions' }
LxxBarebonesPerson class >> parentSlotDefinition [
	<slotDefinition>
	^ LcsGlobalCollectionReferenceSlotDefinition new
		slotName: 'parent';
		moduleName: LxxBarebonesSystem moduleName;
		collectionSlotName: 'persons';
		yourself
]

{ #category : #accessing }
LxxBarebonesPerson >> dateOfBirth [
	^ self getValueOfSlotNamed: 'dateOfBirth'
]

{ #category : #accessing }
LxxBarebonesPerson >> dateOfBirth: anObject [
	self setValueOfSlotNamed: 'dateOfBirth' to: anObject
]
