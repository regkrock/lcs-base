Class {
	#name : 'LcsZipCode',
	#superclass : 'LcsBasePostCode',
	#category : 'Lcs-Geography-Domain',
	#package : 'Lcs-Geography',
	#tag : 'Domain'
}

{ #category : 'slot definition' }
LcsZipCode class >> codeSlotDefinition [
	<slotDefinition>
	^ super codeSlotDefinition
		addValidationCondition: [ :value :parentDomainObject :oldValue | (value matchesRegex: '[0-9][0-9][0-9][0-9][0-9]') not ] description: 'Zipcode format should be 00000';
		yourself
]
