Class {
	#name : 'LcsDateOfBirthSlotExamples',
	#superclass : 'LcsObjectExamples',
	#category : 'Lcs-SlotDefinitionsTests-Examples',
	#package : 'Lcs-SlotDefinitionsTests',
	#tag : 'Examples'
}

{ #category : 'tests' }
LcsDateOfBirthSlotExamples >> newDateOfBirthSlot [
	<gtExample>
	| slot |
	slot := LcsDateOfBirthSlot new.
	self assert: slot initialValue equals: Date today.
	^ slot
]

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
LcsDateOfBirthSlotExamples >> personWithDateOfBirthUpdatedFromInitialValue [
	<gtExample>
	| person firstChangedDateOfBirth secondChangedDateOfBirth initialDateOfBirth |

	self ensureCurrentSystemIsPrototypeSystem.
	initialDateOfBirth := Date today.
	firstChangedDateOfBirth := Date newDay: 1 month: 1 year: 2000.
	secondChangedDateOfBirth := Date newDay: 1 month: 1 year: 2010.

	person := LxxPerson new.
	"Test initial date of birth when new person is created"
	self assert: person dateOfBirth equals: initialDateOfBirth.
	self assert: (person getPersistedValueOf: 'dateOfBirth') equals: initialDateOfBirth.

	"Changed date of birth before applying the changes"
	person dateOfBirth: firstChangedDateOfBirth.
	self assert: person dateOfBirth equals: firstChangedDateOfBirth.
	self assert: (person getPersistedValueOf: 'dateOfBirth') equals:firstChangedDateOfBirth.

	self currentSystem applyChanges.
	
	"After applying the changes, now change the date of birth again"
	self assert: person dateOfBirth equals: firstChangedDateOfBirth.
	self assert: (person getPersistedValueOf: 'dateOfBirth') = firstChangedDateOfBirth.

	person dateOfBirth: secondChangedDateOfBirth.
	self assert: person dateOfBirth equals: secondChangedDateOfBirth.
	self assert: (person getPersistedValueOf: 'dateOfBirth') = firstChangedDateOfBirth.

	self currentUnitOfWork applyChanges.

	self assert: person dateOfBirth equals: secondChangedDateOfBirth.
	self assert: (person getPersistedValueOf: 'dateOfBirth') = secondChangedDateOfBirth.
	^ person
]

{ #category : 'tests' }
LcsDateOfBirthSlotExamples >> slotWithChangedInitialDate [
	<gtExample>
	| initialValue dateOfBirthSlot |
	dateOfBirthSlot := self newDateOfBirthSlot.
	initialValue := dateOfBirthSlot initialValue.
	self assert: dateOfBirthSlot initialValue equals: Date today.

	dateOfBirthSlot initialValueBlock: [ Date today subtractDays: 10 ].
	self assert: dateOfBirthSlot initialValue equals: (Date today subtractDays: 10).
	^ dateOfBirthSlot
]
