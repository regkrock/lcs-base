Class {
	#name : #LxxCanadaPostalCode,
	#superclass : #LxxBasePostCode,
	#category : #'Lcs-PrototypeSystem-Base'
}

{ #category : #'slot definition\t' }
LxxCanadaPostalCode class >> codeSlotDefinition [
	"<slotDefinition>"
	^ super codeSlotDefinition
		addValidationCondition: [ :value :domainObject :oldValue | (value matchesRegex: '[A-Z][0-9][A-Z]\s[0-9][A-Z][0-9]|[A-Z][0-9][A-Z][0-9][A-Z][0-9]') not ] description: 'Postalcode format should be A1A 1A1';
		yourself
]
