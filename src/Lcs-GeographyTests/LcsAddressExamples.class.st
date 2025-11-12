Class {
	#name : #LcsAddressExamples,
	#superclass : #LcsObjectExamples,
	#category : #'Lcs-GeographyTests-Examples'
}

{ #category : #examples }
LcsAddressExamples class >> usaAddress [
	^ self new usaAddress
]

{ #category : #examples }
LcsAddressExamples >> address [
	<gtExample>
	| address defaultCountry |
	self ensureCurrentSystemIsDemoSystem.
	address := LcsAddress new.
	defaultCountry := self currentSystem geographyModule countries defaultInstance.
	self assert: address country equals: defaultCountry.
	self assert: address postalCode class equals: defaultCountry postalCodeClass.
	self assert: address province equals:  defaultCountry subdivisions defaultInstance.
	^ address
]

{ #category : #examples }
LcsAddressExamples >> britishAddress [
	<gtExample>
	| address country |
	address := self address.

	country := self currentSystem geographyModule countries find: [:each | each isoCode = 'GB'].

	address country: country.
	
	self assert: address country equals: country.
	self assert: address postalCode class equals: country postalCodeClass.
	self assert: address province equals: country subdivisions defaultInstance.
	
	address postCode: 'SY10 7LT'.
	self assert: address postCode equals: 'SY10 7LT'.
	
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
		
	address postCode: 'K8A 6W8'.
	self assert: address postCode equals: 'K8A 6W8'.
	
	^ address
]

{ #category : #examples }
LcsAddressExamples >> monroeNjUSAAddress [
	<gtExample>
	| address |
	address := self njUSAAddress.

	address city: 'Monroe'.
	address postalCode code: '08831'.
	self assert: address postalCode code equals: '08831'.
	self assert: address city equals: 'Monroe'.
	
	^ address
]

{ #category : #examples }
LcsAddressExamples >> njUSAAddress [
	<gtExample>
	| address |
	address := self usaAddress.

	address province: 'NJ'.
	self assert: address province isoCode equals: 'NJ'.
		
	^ address
]

{ #category : #examples }
LcsAddressExamples >> nyUSAAddress [
	<gtExample>
	| address |
	address := self usaAddress.

	address province: 'NY'.
	self assert: address province isoCode equals: 'NY'.
		
	address postalCode code: '10280'.
	self assert: address postalCode code equals: '10280'.
	
	^ address
]

{ #category : #examples }
LcsAddressExamples >> usaAddress [
	<gtExample>
	| address country |
	address := self address.

	country := self currentSystem geographyModule countries find: [:each | each isoCode = 'US'].

	address country: country.
	
	self assert: address country equals: country.
	self assert: address postalCode class equals: country postalCodeClass.
	self assert: address province equals: country subdivisions defaultInstance.
		
	^ address
]
