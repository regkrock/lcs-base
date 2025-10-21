Class {
	#name : #LxxZipCode,
	#superclass : #LxxBasePostCode,
	#category : #'Lcs-PrototypeSystem-Base'
}

{ #category : #'slot definition' }
LxxZipCode class >> codeSlotDefinition [
	"<slotDefinition>"
	^ super codeSlotDefinition
		addValidationCondition: [ :value :domainObject :oldValue | value matchesRegex: '[0-9][0-9][0-9][0-9][0-9]' ] description: 'Zipcode format should be 00000';
		yourself
]
