Class {
	#name : #LcsCountryExamples,
	#superclass : #LcsObjectExamples,
	#category : #'Lcs-GeographyTests-Examples'
}

{ #category : #examples }
LcsCountryExamples >> canada [
	<gtExample>
	| country commonName formalName isoCode isoCode3 isoNumber subdivisionName subdivisionClass postalCodeClass |
	self ensureCurrentSystemIsMainSystem.
	commonName := 'Canada'.
	formalName := 'Dominion of Canada'.
	isoCode := 'CA'.
	isoCode3 := 'CAD'.
	isoNumber := '123'.
	subdivisionName := 'Province'.
	subdivisionClass := LcsCanadaSubdivision.
	postalCodeClass := LcsCanadaPostalCode.
	country := LcsCountry new
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

{ #category : #examples }
LcsCountryExamples >> error [
	<gtExample>
	| country commonName formalName isoCode isoCode3 isoNumber subdivisionName |
	self ensureCurrentSystemIsMainSystem.
	commonName := ''.
	formalName := 'Unknown'.
	isoCode := ''.
	isoCode3 := ''.
	isoNumber := ''.
	subdivisionName := ''.
	country := LcsCountry new
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

{ #category : #examples }
LcsCountryExamples >> unknown [
	<gtExample>
	| country commonName formalName isoCode isoCode3 isoNumber subdivisionName |
	self ensureCurrentSystemIsMainSystem.
	commonName := '   '.
	formalName := 'Unknown'.
	isoCode := '  '.
	isoCode3 := '   '.
	isoNumber := '   '.
	subdivisionName := ''.
	country := LcsCountry new
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
