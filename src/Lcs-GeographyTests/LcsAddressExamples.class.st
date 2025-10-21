Class {
	#name : #LcsAddressExamples,
	#superclass : #LcsObjectExamples,
	#category : #'Lcs-GeographyTests-Examples'
}

{ #category : #examples }
LcsAddressExamples >> address [
	<gtExample>
	| address defaultCountry |
	self ensureCurrentsystemIsMainSystem.
	address := LcsAddress new.
	defaultCountry := self currentSystem geographyModule countries defaultInstance.
	self assert: address country equals: defaultCountry.
	self assert: address postalCode class equals: defaultCountry postalCodeClass.
	self assert: address province equals:  defaultCountry subdivisions defaultInstance.
	^ address
]

{ #category : #examples }
LcsAddressExamples >> canadaAddress [
	<gtExample>
	| address country |
	address := self address.

	country := self currentSystem geographyModule countries find: [:each | each isoCode = 'CA'].

	address country: country.
	
	self assert: address country equals: country.
	self assert: address postalCode class equals: country postalCodeClass.
	self assert: address province equals: country subdivisions defaultInstance.
	
	address province: 'ON'.
	self assert: address province isoCode equals: 'ON'.
		
	address postalCode code: 'K8A 6W8'.
	self assert: address postalCode code equals: 'K8A 6W8'.
	
	^ address
]
