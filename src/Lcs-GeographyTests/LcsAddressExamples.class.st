Class {
	#name : 'LcsAddressExamples',
	#superclass : 'LcsObjectExamples',
	#category : 'Lcs-GeographyTests-Examples',
	#package : 'Lcs-GeographyTests',
	#tag : 'Examples'
}

{ #category : 'convenience' }
LcsAddressExamples class >> usaAddress [
	^ self new usaAddress
]

{ #category : 'examples' }
LcsAddressExamples >> britishAddress [
	<gtExample>
	| address country |
	address := self newAddress.

	country := self currentSystem geographyModule countries find: [:each | each isoCode = 'GB'].

	address country: country.
	
	self assert: address country equals: country.
	self assert: address postalCode class equals: country postalCodeClass.
	self assert: address province equals: country subdivisions defaultInstance.
	
	address postCode: 'SY10 7LT'.
	self assert: address postCode equals: 'SY10 7LT'.
	
	^ address
]

{ #category : 'examples' }
LcsAddressExamples >> canadaAddress [
	<gtExample>
	| address country |
	address := self newAddress.

	country := self currentSystem geographyModule countries find: [:each | each isoCode = 'CA'].

	address addressType: 'home'.
	address streetNumber: '12345'.
	address streetName: 'Witt Rd'.
	address additionalDeliveryInformation: 'RR#7'.
	address city: 'Pembroke'.
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

{ #category : 'examples' }
LcsAddressExamples >> monroeNjUSAAddress [
	<gtExample>
	| address |
	address := self njUSAAddress.
	address city: 'Monroe'.
	address postCode: '08831'.
	self assert: address postCode equals: '08831'.
	self assert: address postalCode code equals: '08831'.
	self assert: address city equals: 'Monroe'.
	^ address
]

{ #category : 'examples' }
LcsAddressExamples >> newAddress [
	<gtExample>
	| address defaultCountry addresses |
	LcsAddress hasSlotModel ifFalse: [ self ensureCurrentSystemIsDemoSystem].
	defaultCountry := self currentSystem geographyModule countries defaultInstance.
	addresses := self currentSystem geographyModule addresses.

	address := LcsAddress new.
	self assert: (addresses pendingAdds includes: address).
	self assert: (address parent == addresses).
	self assert: address addressType isUnknown.
	self assert: address streetName equals: ''.
	self assert: address streetNumber equals: ''.
	self assert: address unit equals: ''.
	self assert: address additionalDeliveryInformation equals: ''.
	self assert: address postBox equals: ''.
	self assert: address city equals: ''.
	self assert: address postCode equals: ''.
	self assert: address postalCode class = LcsGenericPostalCode.
	self assert: address postalCode class equals: defaultCountry postalCodeClass.
	self assert: address country equals: defaultCountry.
	self assert: address dateRange effectiveDate year equals: 1970.
	self assert: address dateRange expiryDate year equals: 2100.
	self assert: address province equals:  defaultCountry subdivisions defaultInstance.
	self assert: address isUnknown not.
	^ address
]

{ #category : 'examples' }
LcsAddressExamples >> njUSAAddress [
	<gtExample>
	| address |
	address := self usaAddress.

	address province: 'NJ'.
	self assert: address province isoCode equals: 'NJ'.
		
	^ address
]

{ #category : 'examples' }
LcsAddressExamples >> nyUSAAddress [
	<gtExample>
	| address |
	address := self usaAddress.

	address province: 'NY'.
	self assert: address province isoCode equals: 'NY'.
		
	address postalCode code: '10280'.
	self assert: address postalCode code equals: '10280'.
	self assert: address postCode equals: '10280'.
		
	^ address
]

{ #category : 'examples' }
LcsAddressExamples >> seasMonmouthAddress [
	<gtExample>
	| address |
	address := self njUSAAddress.

	address 
		addressType: 'work';
		city: 'Mattawan';
		postBox: 'PO Box 891';
		postCode: '07747'.
	self assert: address addressType code = 'work'.
	^ address
]

{ #category : 'examples' }
LcsAddressExamples >> usaAddress [
	<gtExample>
	| address country |
	address := self newAddress.

	country := self currentSystem geographyModule countries find: [:each | each isoCode = 'US'].

	address country: country.
	
	self assert: address country equals: country.
	self assert: address postalCode class equals: country postalCodeClass.
	self assert: address province equals: country subdivisions defaultInstance.
		
	^ address
]
