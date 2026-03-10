Class {
	#name : 'LcsDateOfBirthSlot',
	#superclass : 'LcsDateSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'convenience' }
LcsDateOfBirthSlot >> domainClassName [
	^ self domainClass ifNil: [ 'nil' ] ifNotNil: [ :class | class name]
]

{ #category : 'initialize' }
LcsDateOfBirthSlot >> initialize [
	super initialize.
	self slotName: 'dateOfBirth'.
	self 
		addValidationConditionBlock: [ :newDate :parentDomainObject :oldValue |  
			((newDate year) > (Date today year - 120)) and: [ newDate <= Date today ] ] 
		description: 'Age must be between 0 and 120 years'
]

{ #category : 'convenience' }
LcsDateOfBirthSlot >> slotClassName [
	^ self class name
]
