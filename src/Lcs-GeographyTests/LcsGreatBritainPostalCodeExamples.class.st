Class {
	#name : 'LcsGreatBritainPostalCodeExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-GeographyTests-Examples',
	#package : 'Lcs-GeographyTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsGreatBritainPostalCodeExamples >> invalidPostalCode [
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
LcsGreatBritainPostalCodeExamples >> newPostalCode [
	<gtExample>
	<after: #clearUnitOfWork>
	| postalCode codeSlot |
	self ensureCurrentSystemIsDemoSystem.
	postalCode := LcsGreatBritainPostalCode new.
	codeSlot := postalCode slotDefinitionNamed: 'code'.
	self assert: codeSlot pattern equals: LcsGreatBritainPostalCode postalCodeRegex.
	self assert: codeSlot tooltip equals: LcsGreatBritainPostalCode postalCodeTooltip.
	^ postalCode
]

{ #category : 'examples' }
LcsGreatBritainPostalCodeExamples >> validPostalCode [
	<gtExample>
	<after: #clearUnitOfWork>
	| postalCode |
	self ensureCurrentSystemIsDemoSystem.
	postalCode := self newPostalCode.
	postalCode code: 'SY10 7LT'.
	self assert: postalCode code equals: 'SY10 7LT'.
	
	postalCode code: 'sy10 7lt'.
	self assert: postalCode code equals: 'SY10 7LT'

]
