Class {
	#name : 'LcsZipCode',
	#superclass : 'LcsBasePostCode',
	#category : 'Lcs-Geography-Core',
	#package : 'Lcs-Geography',
	#tag : 'Core'
}

{ #category : 'slot definition' }
LcsZipCode class >> codeSlotDefinition [
	<accessorSlotDefinition>
	^ super codeSlotDefinition
		addValidationCondition: [ :value :parentDomainObject :oldValue | (value matchesRegex: '[0-9][0-9][0-9][0-9][0-9]') not ]
			description: 'Zipcode format should be 00000';
		yourself
]
