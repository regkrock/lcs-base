Class {
	#name : 'LcsDateOfBirthSlot',
	#superclass : 'LcsDateSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'initialize' }
LcsDateOfBirthSlot >> initialize [
	super initialize.
	self slotName: 'dateOfBirth'.
	self 
		addValidationCondition: [ :newDate :parentDomainObject :oldValue |  
			newDate year < (Date today year - 120) or: [ newDate > Date today ] ] 
		description: 'Age must be between 0 and 120 years'
]
