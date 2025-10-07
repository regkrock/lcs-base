Class {
	#name : #LcsPersonExamples,
	#superclass : #LcsObjectExamples,
	#category : #'Lcs-LegalEntitiesTests-Examples'
}

{ #category : #examples }
LcsPersonExamples >> johnFreeman [
	<gtExample>
	| person |
	self ensureCurrentsystemIsMainSystem.
	person := 
		LcsPerson new
			surname: 'Freeman';
			firstName: 'John';
			middleNames: 'Edgar';
			dateOfBirth: '01-01-1990';
			gender: 'male';
			yourself.
	self assert: person surname equals: 'Freeman'.
	self assert: person firstName equals: 'John'.
	self assert: person middleNames equals: 'Edgar'.
	self assert: person dateOfBirth asString equals: '1 January 1990'.
	self assert: person gender code = 'male'.
	self assert: person fullName = 'John Edgar Freeman'.
	self assert: person entityName = 'John Edgar Freeman'.
	^ person
]

{ #category : #examples }
LcsPersonExamples >> persoWithInvalidBirthdate [
	<gtExample>
	| person |
	self ensureCurrentsystemIsMainSystem.
	[ person := 
		LcsPerson new
			surname: 'Freeman';
			firstName: 'John';
			middleNames: 'Edgar';
			dateOfBirth: '01-01-1000xxxxxx';
			gender: 'male';
			yourself ]
				on:LcsSlotValidationError
				do: [ :s | s return: 'error' ].
	self assert: person equals: nil.
	^ person
]

{ #category : #examples }
LcsPersonExamples >> persoWithVeryOldBirthdate [
	<gtExample>
	| person |
	self ensureCurrentsystemIsMainSystem.
	[ person := 
		LcsPerson new
			surname: 'Freeman';
			firstName: 'John';
			middleNames: 'Edgar';
			dateOfBirth: '01-01-1000';
			gender: 'male';
			yourself ]
				on:LcsSlotValidationError
				do: [ :s | s return: 'error' ].
	self assert: person equals: nil.
	^ person
]
