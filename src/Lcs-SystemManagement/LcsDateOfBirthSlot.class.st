Class {
	#name : #LcsDateOfBirthSlot,
	#superclass : #LcsDateSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #defaults }
LcsDateOfBirthSlot >> defaultInputComponentClassName [
	^ #'LuiDatePicker'
]

{ #category : #initialize }
LcsDateOfBirthSlot >> initialize [
	super initialize.
	self slotName: 'dateOfBirth'.
	self addValidationCondition: [ :value | value year < Date today year - 120 and: [ value > Date today ] ] description: 'Age must be between 0 and 120 years'
]
