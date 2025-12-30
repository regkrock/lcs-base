Class {
	#name : 'LcsCountryExamples',
	#superclass : 'LcsObjectExamples',
	#category : 'Lcs-GeographyTests-Examples',
	#package : 'Lcs-GeographyTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsCountryExamples >> canada [
	<gtExample>
	| country commonName formalName isoCode isoCode3 isoNumber subdivisionName subdivisionClass postalCodeClass |
	self ensureCurrentSystemIsDemoSystem.
	commonName := 'Canada'.
	formalName := 'Dominion of Canada'.
	isoCode := 'CA'.
	isoCode3 := 'CAD'.
	isoNumber := '123'.
	subdivisionName := 'Province'.
	subdivisionClass := LcsCanadaSubdivision.
	postalCodeClass := LcsCanadaPostalCode.
	country := self newCountry
			commonName: commonName;
			formalName: formalName;
			isoCode: isoCode;
			isoCode3: isoCode3;
			isoNumber: isoNumber;
			subdivisionName: subdivisionName;
			subdivisionClass: subdivisionClass;
			postalCodeClass: postalCodeClass;
			yourself.
	self assert: country commonName equals: commonName.
	self assert: country formalName equals: formalName.
	self assert: country isoCode equals: isoCode.
	self assert: country isoCode3 equals: isoCode3.
	self assert: country isoNumber equals: isoNumber.
	self assert: country subdivisionName equals: subdivisionName.
	self assert: country subdivisionClass equals: subdivisionClass.
	self assert: country postalCodeClass equals: postalCodeClass.
	^ country
]

{ #category : 'examples' }
LcsCountryExamples >> error [
	<gtExample>
	| country commonName formalName isoCode isoCode3 isoNumber subdivisionName |
	commonName := ''.
	formalName := 'Unknown'.
	isoCode := ''.
	isoCode3 := ''.
	isoNumber := ''.
	subdivisionName := ''.
	country := self newCountry
			commonName: commonName;
			formalName: formalName;
			isoCode: isoCode;
			isoCode3: isoCode3;
			isoNumber: isoNumber;
			subdivisionName: subdivisionName;
			yourself.
	self assert: country commonName equals: commonName.
	self assert: country formalName equals: formalName.
	self assert: country isoCode equals: isoCode.
	self assert: country isoCode3 equals: isoCode3.
	self assert: country isoNumber equals: isoNumber.
	self assert: country subdivisionName equals: subdivisionName.
	^ country
]

{ #category : 'examples' }
LcsCountryExamples >> newCountry [
	<gtExample>
	| country |
	LcsCountry hasSlotModel ifFalse: [ self ensureCurrentSystemIsDemoSystem ].
	country := LcsCountry new.
	self assert: country commonName equals: '   '.
	self assert: country formalName equals: '   '.
	self assert: country isoCode equals: '  '.
	self assert: country isoCode3 equals: '   '.
	self assert: country isoNumber equals: '   '.
	self assert: country subdivisionName equals: ''.
	self assert: country subdivisionClass == LcsCountrySubdivision.
	self assert: country postalCodeClass == LcsGenericPostalCode.
	^ country
]

{ #category : 'examples' }
LcsCountryExamples >> unknown [
	<gtExample>
	| country commonName formalName isoCode isoCode3 isoNumber subdivisionName |
	commonName := '   '.
	formalName := 'Unknown'.
	isoCode := '  '.
	isoCode3 := '   '.
	isoNumber := '   '.
	subdivisionName := ''.
	country := self newCountry
			commonName: commonName;
			formalName: formalName;
			isoCode: isoCode;
			isoCode3: isoCode3;
			isoNumber: isoNumber;
			subdivisionName: subdivisionName;
			yourself.
	self assert: country commonName equals: commonName.
	self assert: country formalName equals: formalName.
	self assert: country isoCode equals: isoCode.
	self assert: country isoCode3 equals: isoCode3.
	self assert: country isoNumber equals: isoNumber.
	self assert: country subdivisionName equals: subdivisionName.
	^ country
]
