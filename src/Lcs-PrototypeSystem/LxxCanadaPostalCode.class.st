Class {
	#name : 'LxxCanadaPostalCode',
	#superclass : 'LxxBasePostCode',
	#category : 'Lcs-PrototypeSystem-Base',
	#package : 'Lcs-PrototypeSystem',
	#tag : 'Base'
}

{ #category : 'slot definition\t' }
LxxCanadaPostalCode class >> codeSlotDefinition [
	"<accessorSlotDefinition>"
	^ super codeSlotDefinition
		addValidationCondition: [ :value :parentDomainObject :oldValue | 
				(value
					matchesRegex: '[A-Z][0-9][A-Z]\s[0-9][A-Z][0-9]|[A-Z][0-9][A-Z][0-9][A-Z][0-9]')
					not ]
			description: 'Postalcode format should be A1A 1A1';
		yourself
]
