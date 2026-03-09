Class {
	#name : 'LxxAddressExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-PrototypeSystemTests-Examples',
	#package : 'Lcs-PrototypeSystemTests',
	#tag : 'Examples'
}

{ #category : 'as yet unclassified' }
LxxAddressExamples >> newAddress [
	<gtExample>
	| address |
	self ensureCurrentSystemIsPrototypeSystem.
	address := LxxAddress new.
	self assert: address dateRange parent == address.
	self assert: address dateRange isInEffect.
	self assert: address dateRange effectiveDate equals: LcsDateRangeSlot defaultEffectiveDate .
	self assert: address dateRange expiryDate equals: LcsDateRangeSlot defaultExpiryDate .
	^address
]
