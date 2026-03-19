Class {
	#name : 'LcsCountrySubdivisionClassSlotSlot',
	#superclass : 'LcsExamples',
	#category : 'Lcs-SlotDefinitionsTests-Examples',
	#package : 'Lcs-SlotDefinitionsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsCountrySubdivisionClassSlotSlot >> newSlot [
	<gtExample>
	| slot errorMessage |
	slot := LcsCountrySubdivisionClassSlot new.
	self assert: slot slotName equals: 'subdivisionClass'.
	slot superclassClass subclassesDo: [ :eachClass | self assert: (slot slotTypes includes: eachClass) ].
	self assert: slot initialValue equals: LcsCountrySubdivision.
	self assert: slot superclassClass equals: LcsBaseCountrySubdivision.
	self assert: slot slotTypeRules collection first  validationErrorMessage equals: 'a LcsCountrySubdivisionClassSlot (subdivisionClass) is not in the slot types list'.
	self should: [ slot validate: LcsBaseCountrySubdivision ] raise: LcsInvalidSlotTypeError.
	errorMessage := [ slot validate: LcsBaseCountrySubdivision ]
			on: LcsInvalidSlotTypeError
			do: [ :s | s return: s messageText ].
	self
		assert: errorMessage
		equals: 'Attempt to update subdivisionClass  slot("LcsCountrySubdivisionClassSlot") in "nil" with: LcsBaseCountrySubdivision'.
	^ slot
]
