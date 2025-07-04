Class {
	#name : #LcsCanadaPostalCode,
	#superclass : #LcsBasePostCode,
	#category : #'Lcs-Geography-Domain'
}

{ #category : #'slot definition\t' }
LcsCanadaPostalCode class >> codeSlotDefinition [
	"<slotDefinition>"
	^ super codeSlotDefinition
		addValidationCondition: [ :value :domainObject | value matchesRegex: '[A-Z][0-9][A-Z]\s[0-9][A-Z][0-9]|[A-Z][0-9][A-Z][0-9][A-Z][0-9]' ] description: 'Postalcode format should be A1A 1A1';
		yourself
]
