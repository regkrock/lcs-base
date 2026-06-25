Class {
	#name : 'LxxPersonExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-PrototypeSystemTests-Examples',
	#package : 'Lcs-PrototypeSystemTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LxxPersonExamples >> johnFreeman [
	<gtExample>
	| person |
	person := self newPerson
			firstName: 'John';
			middleName: 'Edgar';
			lastName: 'Freeman'.
	self assert: person firstName equals: 'John'.
	self assert: person lastName equals: 'Freeman'.
	self assert: person middleName equals: 'Edgar'.
	self
		assert: ((person slotDefinitionNamed: 'lastName') persistedSlotVarIn: person)
		equals: 'Freeman'.
	^ person
]

{ #category : 'examples' }
LxxPersonExamples >> lastNameSlotDefinition [
	<gtExample>
	<after: #clearUnitOfWork>
	| slot |
	self ensureCurrentSystemIsPrototypeSystem.
	slot := (LxxPerson slotModel slotDefinitionNamed: 'lastName').
	self assert: (slot isKindOf: LcsStringSlot).
	self assert: slot slotName equals: 'lastName'.
	^ slot
]

{ #category : 'examples' }
LxxPersonExamples >> newPerson [
	<gtExample>
	<after: #clearUnitOfWork>
	| person |
	self ensureCurrentSystemIsPrototypeSystem.
	person := LxxPerson new.
	self assert: person isInAddingState.
	self assert: person lastName isEmpty.
	self assert: person firstName isEmpty.
	self assert: person middleName isEmpty.
	self assert: ((person slotDefinitionNamed: 'lastName') persistedSlotVarIn: person) equals: ''.
	self assert: person weight isZero.
	self should: [ person weight: -1 ] raise: Error.
	self should: [ person weight: 50000000 ] raise: Error.
	self shouldnt: [ person weight: 180 ] raise: Error.
	self assert: person weight equals: 180.
	self assert: person skills class equals: LxxSubsetSkills.
	self assert: person skills hasNoElements.
	^ person
]

{ #category : 'tests' }
LxxPersonExamples >> personWithSwappedDatesOfBirth [
	<gtExample>
	<after: #clearUnitOfWork>
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

	"self currentSystem applyChanges."
	
	"After applying the changes, now change the date of birth again"
	"self assert: person dateOfBirth equals: firstChangedDateOfBirth.
	self assert: (person getPersistedValueOf: 'dateOfBirth') = firstChangedDateOfBirth.

	person dateOfBirth: secondChangedDateOfBirth.
	self assert: person dateOfBirth equals: secondChangedDateOfBirth.
	self assert: (person getPersistedValueOf: 'dateOfBirth') = firstChangedDateOfBirth.

	self currentUnitOfWork applyChanges.

	self assert: person dateOfBirth equals: secondChangedDateOfBirth.
	self assert: (person getPersistedValueOf: 'dateOfBirth') = secondChangedDateOfBirth."
	^ person
]

{ #category : 'examples' }
LxxPersonExamples >> personWithTwoSkills [
	<gtExample>
	<after: #clearUnitOfWork>
	| person |
	person := self newPerson.
	self assert: person isInAddingState.
	self assert: person skills hasNoElements.
	person skills add: (self currentSystem skills find: [:each | each skillCode = '1']).
	person skills add: (self currentSystem skills find: [:each | each skillCode = '2']).
	person skills add: (self currentSystem skills find: [:each | each skillCode = '2']).
	self assert: person skills pendingAddsSize = 2.
	"self currentUnitOfWork applyChanges.
	self assert: person skills pendingAddsSize = 0.
	self assert: person skills collection size = 2. "
	^ person
]

{ #category : 'examples' }
LxxPersonExamples >> personWithWeightChangedTo100_5 [
	<gtExample>
	| person |
	person := self newPerson.
	self assert: person weight isZero.
	person weight: 100.5.
	self assert: person isInAddingState.
	self assert: person weight equals: 100.5.
	self assert: ((person slotDefinitionNamed: 'weight') persistedSlotVarIn: person) equals: 100.5.
	"self currentSystem applyChanges.
	self assert: ((person slotDefinitionNamed: 'weight') persistedSlotVarIn: person) equals: 100.5."
	^ person
]

{ #category : 'tests' }
LxxPersonExamples >> slotDefintiionViewItems [
	<gtExample>
	<after: #clearUnitOfWork>
	| allSlotDefinitionViewItems|
	self ensureCurrentSystemIsPrototypeSystem.
	allSlotDefinitionViewItems := LxxPerson slotDefinitionViewItems.
	self assert: allSlotDefinitionViewItems notEmpty.
	^ allSlotDefinitionViewItems
]
