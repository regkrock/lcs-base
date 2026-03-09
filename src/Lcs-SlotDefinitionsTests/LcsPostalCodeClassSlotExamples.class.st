Class {
	#name : 'LcsPostalCodeClassSlotExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-SlotDefinitionsTests-Examples',
	#package : 'Lcs-SlotDefinitionsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsPostalCodeClassSlotExamples >> genericPostalCodeClassSlot [
	<gtExample>
	| slot errorMessage |
	slot := self newSlot.
	slot superclassClass subclassesDo: [ :eachClass | slot addSlotType: eachClass ].
	self assert: slot slotName equals: 'postalCodeClass'.
	slot superclassClass subclassesDo: [ :eachClass | self assert: (slot slotTypes includes: eachClass) ].
	self assert: slot initialValue equals: LcsGenericPostalCode.
	self assert: slot superclassClass equals: LcsBasePostCode.
	self assert: slot validationConditions first validationErrorMessage equals: 'This must be a subclass of LcsBasePostCode'.
	self assert: (slot validate: LcsCanadaPostalCode) hasNoErrors.
	self should: [ slot validate: LcsBasePostCode ] raise: LcsSlotValidationError.
	errorMessage := [ slot validate: LcsBasePostCode ]
			on: LcsSlotValidationError
			do: [ :s | s return: s messageText ].
	self
		assert: errorMessage
		equals: 'nil slot: postalCodeClass has validation error: Input class is not a valid subclass'.
	^ slot
]

{ #category : 'examples' }
LcsPostalCodeClassSlotExamples >> newSlot [
	<gtExample>
	^ LcsPostalCodeClassSlot new
]
