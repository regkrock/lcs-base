Class {
	#name : 'LxxZipCode',
	#superclass : 'LxxBasePostCode',
	#category : 'Lcs-PrototypeSystem-Core',
	#package : 'Lcs-PrototypeSystem',
	#tag : 'Core'
}

{ #category : 'slot definition' }
LxxZipCode class >> codeSlotDefinition [
	"<accessorSlotDefinition>"
	^ super codeSlotDefinition
		addValidationCondition: [ :value :parentDomainObject :oldValue | value matchesRegex: '[0-9][0-9][0-9][0-9][0-9]' ]
			description: 'Zipcode format should be 00000';
		yourself
]
