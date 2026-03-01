Class {
	#name : 'LcsDoaminClassSlotExamples',
	#superclass : 'LcsObjectExamples',
	#category : 'Lcs-SlotDefinitionsTests-Examples',
	#package : 'Lcs-SlotDefinitionsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsDoaminClassSlotExamples >> newCountrySubdivisionClassSlot [
	<gtExample>
	| slot |
	slot := LcsCountrySubdivisionClassSlot new.
	self assert: slot slotName equals: 'subdivisionClass'.
	slot superclassClass subclassesDo: [ :eachClass | self assert: (slot slotTypes includes: eachClass) ].
	self assert: slot initialValue equals: LcsCountrySubdivision.
	self assert: slot superclassClass equals: LcsBaseCountrySubdivision.
	self assert: slot validationConditions first validationErrorMessage equals: 'This must be a subclass of LcsBaseCountrySubdivision'.
	^ slot
]

{ #category : 'examples' }
LcsDoaminClassSlotExamples >> newDomainClassSlotSlot [
	<gtExample>
	| slot |
	slot :=  LcsDomainClassSlot new
						slotName: 'subdivisionClass';
						superclassClass:  LcsBaseCountrySubdivision;
						yourself.
	slot superclassClass subclassesDo: [ :eachClass | slot addSlotType: eachClass ].
	self assert: slot slotName equals: 'subdivisionClass'.
	slot superclassClass subclassesDo: [ :eachClass | self assert: (slot slotTypes includes: eachClass) ].
	self assert: slot initialValue equals: LcsCanadaSubdivision.
	self assert: slot superclassClass equals: LcsBaseCountrySubdivision.
	self assert: slot validationConditions first validationErrorMessage equals: 'This must be a subclass of LcsBaseCountrySubdivision'.
	^ slot
]

{ #category : 'examples' }
LcsDoaminClassSlotExamples >> newPostalCodeClassSlot [
	<gtExample>
	| slot |
	slot := LcsPostalCodeClassSlot new.
	slot superclassClass subclassesDo: [ :eachClass | slot addSlotType: eachClass ].
	self assert: slot slotName equals: 'postalCodeClass'.
	slot superclassClass subclassesDo: [ :eachClass | self assert: (slot slotTypes includes: eachClass) ].
	self assert: slot initialValue equals: LcsGenericPostalCode.
	self assert: slot superclassClass equals: LcsBasePostCode.
	self assert: slot validationConditions first validationErrorMessage equals: 'This must be a subclass of LcsBasePostCode'.
	^ slot
]

{ #category : 'examples' }
LcsDoaminClassSlotExamples >> postalCodeClassUsingGenericDomainClassSlotClass [
	<gtExample>
	| slot errorMessage |
	slot := self newPostalCodeClassSlot.
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
LcsDoaminClassSlotExamples >> provinceSubdvisionClassSlotUsingSpecializedDomainClassSlotClass [
	<gtExample>
	| slot errorMessage |
	slot := self newCountrySubdivisionClassSlot.
	self assert: (slot validate: LcsCanadaSubdivision) hasNoErrors.
	self should: [ slot validate: LcsBaseCountrySubdivision ] raise: LcsSlotValidationError.
	errorMessage := [ slot validate: LcsBaseCountrySubdivision ]
			on: LcsSlotValidationError
			do: [ :s | s return: s messageText ].
	self
		assert: errorMessage
		equals: 'nil slot: subdivisionClass has validation error: Input class is not a valid subclass'.
	^ slot
]

{ #category : 'examples' }
LcsDoaminClassSlotExamples >> provinceSubdvisionClassUsingGenericDomainClassSlotClass [
	<gtExample>
	| slot errorMessage |
	slot := self newDomainClassSlotSlot.
	self assert: (slot validate: LcsCanadaSubdivision) hasNoErrors.
	
	self should: [ slot validate: LcsBaseCountrySubdivision ] raise: LcsSlotValidationError.
	errorMessage := [ slot validate: LcsBaseCountrySubdivision ]
			on: LcsSlotValidationError
			do: [ :s | s return: s messageText ].
	self
		assert: errorMessage
		equals: 'nil slot: subdivisionClass has validation error: Input class is not a valid subclass'.
	^ slot
]
