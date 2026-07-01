Class {
	#name : 'LcsZipCodeExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-GeographyTests-Examples',
	#package : 'Lcs-GeographyTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsZipCodeExamples >> invalidPostalCode [
	<gtExample>
	<after: #clearUnitOfWork>
	| postalCode codeSlot |
	self ensureCurrentSystemIsDemoSystem.
	postalCode := self newPostalCode.
	codeSlot := postalCode slotDefinitionNamed: 'code'.
	self should: [ postalCode code: 'a' ] raise: LcsSlotValidationError.
	self should: [ postalCode code: '1234' ] raise: LcsSlotValidationError.
	self should: [ postalCode code: '123456' ] raise: LcsSlotValidationError.
	self should: [ postalCode code: '12345-' ] raise: LcsSlotValidationError.
	self should: [ postalCode code: '12345-123' ] raise: LcsSlotValidationError.
	self should: [ postalCode code: '' ] raise: LcsSlotValidationError.
	self should: [ postalCode code: nil ] raise: LcsInvalidSlotTypeError.
]

{ #category : 'examples' }
LcsZipCodeExamples >> newPostalCode [
	<gtExample>
	<after: #clearUnitOfWork>
	| postalCode codeSlot |
	self ensureCurrentSystemIsDemoSystem.
	postalCode := LcsZipCode new.
	codeSlot := postalCode slotDefinitionNamed: 'code'.
	self assert: codeSlot pattern equals: LcsZipCode postalCodeRegex.
	self assert: codeSlot tooltip equals: LcsZipCode postalCodeTooltip.
	^ postalCode
]

{ #category : 'examples' }
LcsZipCodeExamples >> validPostalCode [
	<gtExample>
	<after: #clearUnitOfWork>
	| postalCode |
	self ensureCurrentSystemIsDemoSystem.
	postalCode := self newPostalCode.
	postalCode code: '01234'.
	self assert: postalCode code equals: '01234'.

	self shouldnt: [ postalCode code: '99950' ] raise: Error.
	self assert: postalCode code equals: '99950'.

	self shouldnt: [ postalCode code: '99950-0001' ] raise: Error.
	self assert: postalCode code equals: '99950-0001'
]
