Class {
	#name : 'LcsCanadaPostalCode',
	#superclass : 'LcsBasePostCode',
	#category : 'Lcs-Geography-Domain',
	#package : 'Lcs-Geography',
	#tag : 'Domain'
}

{ #category : 'slot definition\t' }
LcsCanadaPostalCode class >> codeSlotDefinition [
	<accessorSlotDefinition>
	^ super codeSlotDefinition
		addValidationCondition: [ :value :parentDomainObject :oldValue | 
				(value
					matchesRegex: '[A-Z][0-9][A-Z]\s[0-9][A-Z][0-9]|[A-Z][0-9][A-Z][0-9][A-Z][0-9]')
					not ]
			description: 'Postalcode format should be A1A 1A1';
		yourself
]
