Class {
	#name : 'LcsDoaminClassSlotExamples',
	#superclass : 'LcsObjectExamples',
	#category : 'Lcs-SlotDefinitionsTests-Examples',
	#package : 'Lcs-SlotDefinitionsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsDoaminClassSlotExamples >> postalCodeClassUsingGenericDomainClassSlotClass [
	<gtExample>
	| slotDefinition |
	slotDefinition := LcsPostalCodeClassSlot new.
	slotDefinition superclassClass subclassesDo: [ :eachClass | slotDefinition addSlotType: eachClass ].
	self assert: slotDefinition slotName equals: 'postalCodeClass'.
	slotDefinition superclassClass subclassesDo: [ :eachClass | self assert: (slotDefinition slotTypes includes: eachClass) ].
	self assert: slotDefinition initialValue equals: LcsGenericPostalCode.
	self assert: slotDefinition superclassClass equals: LcsBasePostCode.
	self assert: slotDefinition validationConditions first validationErrorMessage equals: 'This must be a subclass of LcsBasePostCode'.
	self assert: (slotDefinition validate: LcsCanadaPostalCode) hasNoErrors.
	self assert: (slotDefinition validate: LcsBasePostCode) hasErrors.
	self assert: (slotDefinition validate: LcsBasePostCode) errorDescriptions first 
					equals: 'This must be a subclass of LcsBasePostCode'.
	^ slotDefinition
]

{ #category : 'examples' }
LcsDoaminClassSlotExamples >> provinceSubdvisionClassSlotUsingSpecializedDomainClassSlotClass [
	<gtExample>
	| slotDefinition |
	slotDefinition := LcsCountrySubdivisionClassSlot new.
	self assert: slotDefinition slotName equals: 'subdivisionClass'.
	slotDefinition superclassClass subclassesDo: [ :eachClass | self assert: (slotDefinition slotTypes includes: eachClass) ].
	self assert: slotDefinition initialValue equals: LcsCountrySubdivision.
	self assert: slotDefinition superclassClass equals: LcsBaseCountrySubdivision.
	self assert: slotDefinition validationConditions first validationErrorMessage equals: 'This must be a subclass of LcsBaseCountrySubdivision'.
	self assert: (slotDefinition validate: LcsCanadaSubdivision) hasNoErrors.
	self assert: (slotDefinition validate: LcsBaseCountrySubdivision) hasErrors.
	self assert: (slotDefinition validate: LcsBaseCountrySubdivision) errorDescriptions first 
					equals: 'This must be a subclass of LcsBaseCountrySubdivision'.
	^ slotDefinition
]

{ #category : 'examples' }
LcsDoaminClassSlotExamples >> provinceSubdvisionClassUsingGenericDomainClassSlotClass [
	<gtExample>
	| slotDefinition |
	slotDefinition := LcsDomainClassSlot new
						slotName: 'subdivisionClass';
						superclassClass:  LcsBaseCountrySubdivision;
						yourself.
	slotDefinition superclassClass subclassesDo: [ :eachClass | slotDefinition addSlotType: eachClass ].
	self assert: slotDefinition slotName equals: 'subdivisionClass'.
	slotDefinition superclassClass subclassesDo: [ :eachClass | self assert: (slotDefinition slotTypes includes: eachClass) ].
	self assert: slotDefinition initialValue equals: LcsCanadaSubdivision.
	self assert: slotDefinition superclassClass equals: LcsBaseCountrySubdivision.
	self assert: slotDefinition validationConditions first validationErrorMessage equals: 'This must be a subclass of LcsBaseCountrySubdivision'.
	self assert: (slotDefinition validate: LcsCanadaSubdivision) hasNoErrors.
	self assert: (slotDefinition validate: LcsBaseCountrySubdivision) hasErrors.
	self assert: (slotDefinition validate: LcsBaseCountrySubdivision) errorDescriptions first 
					equals: 'This must be a subclass of LcsBaseCountrySubdivision'.
	^ slotDefinition
]
