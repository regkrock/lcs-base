Class {
	#name : 'LcsDateOfBirthSlot',
	#superclass : 'LcsDateSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'initialize' }
LcsDateOfBirthSlot >> earliestBirthdate [
	| today day |
	today := Date today.
	day := (today month = 2 and: [ today dayOfMonth = 29]) ifTrue: [ 28 ] ifFalse: [ today dayOfMonth ].
	^ Date
		newDay: day
		month: today monthIndex
		year: (today year - 120)
]

{ #category : 'initialize' }
LcsDateOfBirthSlot >> initialize [
	super initialize.
	self slotName: 'dateOfBirth'.
	self minimumBlock: [ self earliestBirthdate ].
	self maximumBlock: [ Date today ].
	self rangeRuleErrorMessage: 'Age must be between 0 and 120 years'
]

{ #category : 'properties' }
LcsDateOfBirthSlot >> stepValue [
	^ self propertyAt: #stepValue ifAbsent: [ nil ]
]

{ #category : 'properties' }
LcsDateOfBirthSlot >> stepValue: anInteger [
	^ self propertyAt: #stepValue put: anInteger
]
