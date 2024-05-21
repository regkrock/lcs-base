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
	^ LcsDateOfBirthSlot new
]

{ #category : #'slot definitions' }
LxxBarebonesPerson class >> parentSlotDefinition [
	<slotDefinition>
	^ LcsGlobalCollectionReferenceSlot new
		slotName: 'parent';
		collectionSlotModuleName: LxxBarebonesSystem moduleName;
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
