Class {
	#name : 'LcsDateOfBirthSlotExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-SlotDefinitionsTests-Examples',
	#package : 'Lcs-SlotDefinitionsTests',
	#tag : 'Examples'
}

{ #category : 'tests' }
LcsDateOfBirthSlotExamples >> newDateOfBirthSlotWithDateValidated [
	<gtExample>
	| slot futureDate |
	slot := LcsDateOfBirthSlot new.
	futureDate := Date today addDays: 1.
	self assert: slot validationConditions collectionSize = 1.
	self shouldnt: [ slot validate: Date today ] raise: LcsSlotValidationError.
	self should: [ slot validate: futureDate ] raise: LcsSlotValidationError.
	self
		should: [ slot validate: futureDate for: nil ]
		raise: Error
		description: 'DomainObject is nil so cannot get oldValue. An error is signalled'.
	self
		should: [ slot validate: futureDate for: nil oldValue: nil ]
		raise: LcsSlotValidationError.
	^ slot
]

{ #category : 'tests' }
LcsDateOfBirthSlotExamples >> newSlot [
	<gtExample>
	| slot |
	slot := LcsDateOfBirthSlot new.
	self assert: slot slotName equals: 'dateOfBirth'.
	self assert: slot initialValue equals: Date today.
	^ slot
]

{ #category : 'tests' }
LcsDateOfBirthSlotExamples >> slotWithChangedInitialValueBlock [
	<gtExample>
	| initialValue dateOfBirthSlot |
	dateOfBirthSlot := self newSlot.
	initialValue := dateOfBirthSlot initialValue.
	self assert: dateOfBirthSlot initialValue equals: Date today.

	dateOfBirthSlot initialValueBlock: [ Date today subtractDays: 10 ].
	self assert: dateOfBirthSlot initialValue equals: (Date today subtractDays: 10).
	^ dateOfBirthSlot
]
