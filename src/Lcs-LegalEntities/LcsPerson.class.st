Class {
	#name : #LcsPerson,
	#superclass : #LcsLegalEntity,
	#instVars : [
		'dateOfBirth'
	],
	#category : #'Lcs-LegalEntities'
}

{ #category : #accessing }
LcsPerson class >> dateOfBirthSlotDefinition [
	<slotDefinition>
	^ LcsSlotDefinition new
		slotName: #'dateOfBirth';
		addSlotType: Date;
		yourself
]

{ #category : #accessing }
LcsPerson >> dateOfBirth [
	^ self getValueOfSlotNamed: #dateOfBirth 
]

{ #category : #accessing }
LcsPerson >> dateOfBirth: aDate [
	self setValueOfSlotNamed: #dateOfBirth to: aDate 

]
