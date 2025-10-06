Class {
	#name : #LcsZipCode,
	#superclass : #LcsBasePostCode,
	#category : #'Lcs-Geography-Domain'
}

{ #category : #'slot definition' }
LcsZipCode class >> codeSlotDefinition [
	"<slotDefinition>"
	^ super codeSlotDefinition
		addValidationCondition: [ :value :domainObject :oldValue | value matchesRegex: '[0-9][0-9][0-9][0-9][0-9]' ] description: 'Zipcode format should be 00000';
		yourself
]
