Class {
	#name : #LcsDateOfBirthSlotDefinition,
	#superclass : #LcsDateSlotDefinition,
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #initialization }
LcsDateOfBirthSlotDefinition >> initialize [
	super initialize.
	self slotName: 'dateOfBirth'
]
