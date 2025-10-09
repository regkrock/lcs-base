Class {
	#name : #LcsPersonTest,
	#superclass : #LcsMainSystemRunningTestCase,
	#category : #'Lcs-LegalEntitiesTests-Tests'
}

{ #category : #test }
LcsPersonTest >> testPersonWithInvalidBirthdate [
	| person |
	person := LcsPerson new.
	self should: [ person dateOfBirth: '01-01-1000xxxxxx' ] raise: LcsSlotValidationError
]

{ #category : #test }
LcsPersonTest >> testPersonWithVeryOldBirthdate [
	| person |
	person := LcsPerson new.
	self should: [ person dateOfBirth: '01-01-1000' ] raise: LcsSlotValidationError
]

{ #category : #test }
LcsPersonTest >> testSlotValidationError [
	| person error |
	person := LcsPerson new.
	error := [ person dateOfBirth: '01-01-1000' ] 
				on: LcsSlotValidationError
				do: [ :s | s return: s ].
	self assert: error class = LcsSlotValidationError.
	self assert: error context equals: person.
	self assert: error value equals: (Date fromString: '01-01-1000').
	self assert: error oldValue equals: person dateOfBirth
]
