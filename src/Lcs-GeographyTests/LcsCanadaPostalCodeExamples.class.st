Class {
	#name : 'LcsCanadaPostalCodeExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-GeographyTests-Examples',
	#package : 'Lcs-GeographyTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsCanadaPostalCodeExamples >> invalidPostalCode [
	<gtExample>
	<after: #clearUnitOfWork>
	| postalCode codeSlot |
	self ensureCurrentSystemIsDemoSystem.
	postalCode := self newPostalCode.
	codeSlot := postalCode slotDefinitionNamed: 'code'.
	self should: [ postalCode code: 'a' ] raise: LcsSlotValidationError.
	self should: [ postalCode code: '' ] raise: LcsSlotValidationError.
	self should: [ postalCode code: nil ] raise: LcsInvalidSlotTypeError.

]

{ #category : 'examples' }
LcsCanadaPostalCodeExamples >> newPostalCode [
	<gtExample>
	<after: #clearUnitOfWork>
	| postalCode codeSlot |
	self ensureCurrentSystemIsDemoSystem.
	postalCode := LcsCanadaPostalCode new.
	codeSlot := postalCode slotDefinitionNamed: 'code'.
	self assert: codeSlot pattern equals: LcsCanadaPostalCode postalCodeRegex.
	self assert: codeSlot tooltip equals: LcsCanadaPostalCode postalCodeTooltip.
	^ postalCode
]

{ #category : 'examples' }
LcsCanadaPostalCodeExamples >> validPostalCode [
	<gtExample>
	<after: #clearUnitOfWork>
	| postalCode codeSlot |
	self ensureCurrentSystemIsDemoSystem.
	postalCode := self newPostalCode.
	postalCode code: 'A1A 1A1'.
	self assert: postalCode code equals: 'A1A 1A1'.
	
	postalCode code: 'a1a 1a1'.
	self assert: postalCode code equals: 'A1A 1A1'

]
