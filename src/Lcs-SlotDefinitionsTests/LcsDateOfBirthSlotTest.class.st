Class {
	#name : #LcsDateOfBirthSlotTest,
	#superclass : #LcsWithPrototypeSystemSetUpForTest,
	#category : #'Lcs-SlotDefinitionsTests-Tests'
}

{ #category : #tests }
LcsDateOfBirthSlotTest >> testChangedSlotInDomainObject [
	| domainObject firstChangedDateOfBirth secondChangedDateOfBirth initialDateOfBirth secondChanged |

	initialDateOfBirth := Date today.
	firstChangedDateOfBirth := Date newDay: 1 month: 1 year: 2000.
	secondChangedDateOfBirth := Date newDay: 1 month: 1 year: 2010.

	domainObject := LxxPerson new.
	"Test initial date of birth when new person is created"
	self assert: domainObject dateOfBirth equals: initialDateOfBirth.
	self assert: (domainObject getPersistedValueOf: 'dateOfBirth') = initialDateOfBirth.

	"Changed date of birth before applying the changes"
	domainObject dateOfBirth: firstChangedDateOfBirth.
	self assert: domainObject dateOfBirth equals: firstChangedDateOfBirth.
	self assert: (domainObject getPersistedValueOf: 'dateOfBirth') = firstChangedDateOfBirth.

	self currentSystem applyChanges.
	
	"After applying the changes, now change the date of birth again"
	self assert: domainObject dateOfBirth equals: firstChangedDateOfBirth.
	self assert: (domainObject getPersistedValueOf: 'dateOfBirth') = firstChangedDateOfBirth.

	domainObject dateOfBirth: secondChangedDateOfBirth.
	self assert: domainObject dateOfBirth equals: secondChangedDateOfBirth.
	self assert: (domainObject getPersistedValueOf: 'dateOfBirth') = firstChangedDateOfBirth.

	self currentUnitOfWork applyChanges.

	self assert: domainObject dateOfBirth equals: secondChangedDateOfBirth.
	self assert: (domainObject getPersistedValueOf: 'dateOfBirth') = secondChangedDateOfBirth.
]
