Class {
	#name : 'LcsCountrySubdivisionClassSlotExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-SlotDefinitionsTests-Examples',
	#package : 'Lcs-SlotDefinitionsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsCountrySubdivisionClassSlotExamples >> newSlot [
	<gtExample>
	| slot |
	slot := LcsCountrySubdivisionClassSlot new.
	self assert: slot slotName equals: 'subdivisionClass'.
	self assert: slot slotTypeRules collection size = 1.
	self assert: slot slotTypeRules any class == LcsClassIsMemberSlotTypesRule.
	self assert: slot parent isNil.
	self assert: slot domainClass isNil.
	self assert: slot validationRules hasNoElements.
	self assert: slot initialValue equals: LcsCountrySubdivision.
	self assert: slot superclassClass equals: LcsBaseCountrySubdivision.
	LcsBaseCountrySubdivision subclassesDo: [ :each |
		self assert: (slot slotTypes includes: each) ].
	self assert: (slot validate: LcsCountrySubdivision).
	self assert: (slot validate: LcsCanadaSubdivision).
	self should: [ slot validate: nil ] raise: LcsInvalidSlotTypeError.
	self should: [ slot validate: LcsBasePostCode ] raise: LcsInvalidSlotTypeError.
	^ slot
]

{ #category : 'examples' }
LcsCountrySubdivisionClassSlotExamples >> slotWithValidationError [
	<gtExample>
	<noTest>
	| slot |
	slot := self newSlot.
	slot validate: LcsBaseCountrySubdivision.
	^ slot
]
