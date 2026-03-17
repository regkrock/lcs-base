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
	(slot validateSlotType: 'futureDate').
	^ slot
]

{ #category : 'tests' }
LcsDateOfBirthSlotExamples >> newSlot [
	<gtExample>
	| slot |
	slot := LcsDateOfBirthSlot new.
	self assert: slot slotName equals: 'dateOfBirth'.
	self assert: slot initialValue equals: Date today.
	self assert: slot validationRules collectionSize = 1.
	self verifyValidationConditions: slot.
	^ slot
]

{ #category : 'tests' }
LcsDateOfBirthSlotExamples >> slotValidationError [
	<gtExample>
	<noTest>
	| slot |
	slot := self newSlot.
	(slot validate: (Date today addDays: 1) context: nil oldValue: nil).
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
		should: [ slot validate: 'futureDate' context: nil oldValue: nil ]
		raise: LcsInvalidSlotTypeError
		description: 'Invalid type - a string, not a date'.
	self
		should: [ slot validateSlotType: nil context: nil oldValue: nil ]
		raise: LcsInvalidSlotTypeError
		description: 'Nil is not allowed, so should raise an invalid type'.
	slot beAllowNil.
	self
		assert: (slot validateSlotType: nil context: nil oldValue: nil)
		description: 'Nil is allowed, so shouldnt raise an invalid type'.
	slot beDisallowNil.
	self assert: (slot validate: Date today context: nil oldValue: nil ).
	self
		should: [ slot validate: futureDate context: nil oldValue: nil ]
		raise: LcsSlotValidationError.
	self
		should: [ slot validate: futureDate context: nil ]
		raise: Error
		description: 'DomainObject is nil so cannot get oldValue. An error is signalled'.
	self
		should: [ slot validate: futureDate context: nil oldValue: nil ]
		raise: LcsSlotValidationError
]
