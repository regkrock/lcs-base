Class {
	#name : #LcsPerson,
	#superclass : #LcsLegalEntity,
	#instVars : [
		'dateOfBirth'
	],
	#category : #'Lcs-LegalEntities'
}

{ #category : #'slot definitions' }
LcsPerson class >> dateOfBirthSlotDefinition [
	<slotDefinition>
	^ LcsSlotDefinition new
		slotName: #'dateOfBirth';
		addSlotType: Date;
		yourself
]

{ #category : #'slot definitions' }
LcsPerson class >> parentSlotDefinition [
	<slotDefinition>
	^LcsGlobalCollectonReferenceSlotDefinition new
		slotName: 'parent';
		moduleName: LcsLegalEntitiesModule moduleName;
		collectionSlotName: 'persons';
		yourself
]

{ #category : #accessing }
LcsPerson >> dateOfBirth [
	^ self getValueOfSlotNamed: 'dateOfBirth'
]

{ #category : #accessing }
LcsPerson >> dateOfBirth: anObject [
	self setValueOfSlotNamed: 'dateOfBirth' to: anObject
]
