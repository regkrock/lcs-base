Class {
	#name : 'LcsDateOfBirthSlotExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-SlotDefinitionsTests-Examples',
	#package : 'Lcs-SlotDefinitionsTests',
	#tag : 'Examples'
}

{ #category : 'tests' }
LcsDateOfBirthSlotExamples >> invalidSlotTypeError [
	<gtExample>
	<noTest>
	| slot |
	slot := self newSlot.
	^ (slot verifySlotTypeOf: 'futureDate' for: nil)
]

{ #category : 'tests' }
LcsDateOfBirthSlotExamples >> newSlot [
	<gtExample>
	| slot |
	slot := LcsDateOfBirthSlot new.
	self assert: slot slotName equals: 'dateOfBirth'.
	self assert: slot initialValue equals: Date today.
	self assert: slot validationConditions collectionSize = 1.
	self verifyValidationConditions: slot.
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

{ #category : 'tests' }
LcsDateOfBirthSlotExamples >> verifyValidationConditions: slot [
	| futureDate |
	futureDate := Date today addDays: 1.
	self
		should: [ slot validate: 'futureDate' for: nil oldValue: nil ]
		raise: LcsInvalidSlotTypeError.
	self
		should: [ slot validate: nil for: nil oldValue: nil ]
		raise: LcsInvalidSlotTypeError
		description: 'Nil is not allowed, so should raise an invalid type'.
	slot beAllowNil.
	self
		assert: (slot validate: nil for: nil oldValue: nil)
		description: 'Nil is not allowed, so should raise an invalid type'.
	slot beDisallowNil.
	self assert: (slot validate: Date today for: nil oldValue: nil ).
	self
		should: [ slot validate: futureDate for: nil oldValue: nil ]
		raise: LcsSlotValidationError.
	self
		should: [ slot validate: futureDate for: nil ]
		raise: Error
		description: 'DomainObject is nil so cannot get oldValue. An error is signalled'.
	self
		should: [ slot validate: futureDate for: nil oldValue: nil ]
		raise: LcsSlotValidationError
]
