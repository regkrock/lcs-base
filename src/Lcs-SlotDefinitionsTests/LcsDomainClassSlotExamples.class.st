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
	| slot |
	slot := LcsDomainClassSlot new.
	self assert: slot slotName isNil.
	self assert: slot slotTypeRules collection size = 1.
	self assert: slot slotTypeRules any class == LcsClassIsMemberSlotTypesRule.
	self assert: slot parent isNil.
	self assert: slot domainClass isNil.
	self assert: slot superclassClass equals: LcsDomainObject.
	self assert: slot slotTypes isEmpty.
	^ slot
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
	self should: [ slot validate: LcsBaseCountrySubdivision ] raise: LcsInvalidSlotTypeError.
	errorMessage := [ slot validate: LcsBaseCountrySubdivision ]
			on: LcsInvalidSlotTypeError
			do: [ :s | s return: s messageText ].
	self
		assert: errorMessage
		equals: 'Attempt to update subdivisionClass  slot("LcsDomainClassSlot") in "nil" with: LcsBaseCountrySubdivision'.
	^ slot
]
