Class {
	#name : 'LxxZipCode',
	#superclass : 'LxxBasePostCode',
	#category : 'Lcs-PrototypeSystem-Base',
	#package : 'Lcs-PrototypeSystem',
	#tag : 'Base'
}

{ #category : 'slot definition' }
LxxZipCode class >> codeSlotDefinition [
	"<slotDefinition>"
	^ super codeSlotDefinition
		addValidationCondition: [ :value :parentDomainObject :oldValue | value matchesRegex: '[0-9][0-9][0-9][0-9][0-9]' ] description: 'Zipcode format should be 00000';
		yourself
]
