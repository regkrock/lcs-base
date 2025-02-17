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
	self slotName: 'dateOfBirth'
]
