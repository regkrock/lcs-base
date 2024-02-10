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

	^LcsSlotDefinition new
		slotName: #'dateOfBirth';
		addSlotType: Date;
		yourself
]

{ #category : #accessing }
LcsPerson class >> initializeSlotDefinitions [
	super initializeSlotDefinitions.
	self slotDefinitions addSlotDefinition: self dateOfBirthSlotDefinition
]

{ #category : #accessing }
LcsPerson >> dateOfBirth [
	^ self currentUnitOfWork valueOfSlot: #dateOfBirth in: self
]

{ #category : #accessing }
LcsPerson >> dateOfBirth: aDate [
	self inSlotFor: #dateOfBirth put: aDate 
	"self currentUnitOfWork changedSlot: #dateOfBirth valueTo: aDate in: self"
]

{ #category : #accessing }
LcsPerson >> slotDefintion [

	^(LcsSlotDefinitions newOn: self)
		addSlotDefinition: self dateOfBirthSlotDefinition;
		yourself
]
