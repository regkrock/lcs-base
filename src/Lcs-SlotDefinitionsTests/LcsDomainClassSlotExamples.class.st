Class {
	#name : 'LcsDomainClassSlotExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-SlotDefinitionsTests-Examples',
	#package : 'Lcs-SlotDefinitionsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsDomainClassSlotExamples >> newSlot [
	<gtExample>
	^ LcsDomainClassSlot new
]

{ #category : 'examples' }
LcsDomainClassSlotExamples >> subdivisionClassSlot [
	<gtExample>
	| slot errorMessage |
	slot := self newSlot
			slotName: 'subdivisionClass';
			superclassClass: LcsBaseCountrySubdivision;
			yourself.
	slot superclassClass subclassesDo: [ :eachClass | slot addSlotType: eachClass ].
	self assert: slot slotName equals: 'subdivisionClass'.
	slot superclassClass
		subclassesDo: [ :eachClass | self assert: (slot slotTypes includes: eachClass) ].
	self assert: slot initialValue equals: LcsCanadaSubdivision.
	self assert: slot superclassClass equals: LcsBaseCountrySubdivision.
	self
		assert: slot validationConditions first validationErrorMessage
		equals: 'This must be a subclass of LcsBaseCountrySubdivision'.

	self should: [ slot validate: LcsBaseCountrySubdivision ] raise: LcsSlotValidationError.
	errorMessage := [ slot validate: LcsBaseCountrySubdivision ]
			on: LcsSlotValidationError
			do: [ :s | s return: s messageText ].
	self
		assert: errorMessage
		equals: 'nil slot: subdivisionClass has validation error: Input class is not a valid subclass'.

		
	^ slot
]
