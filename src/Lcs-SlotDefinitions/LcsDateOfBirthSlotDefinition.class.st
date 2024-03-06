Class {
	#name : #LcsDateOfBirthSlotDefinition,
	#superclass : #LcsDateSlotDefinition,
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #accessing }
LcsDateOfBirthSlotDefinition >> initialize [
	super initialize.
	self slotName: 'dateOfBirth'
]
