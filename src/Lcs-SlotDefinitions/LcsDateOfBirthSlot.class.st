Class {
	#name : #LcsDateOfBirthSlot,
	#superclass : #LcsDateSlot,
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #defaults }
LcsDateOfBirthSlot >> defaultInputComponentClassName [
	^ #'LuiDatePicker'
]

{ #category : #initialization }
LcsDateOfBirthSlot >> initialize [
	super initialize.
	self slotName: 'dateOfBirth'
]
