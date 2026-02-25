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
LcsCountryExamples >> countryXxxxxx [
	<gtExample>
	| country countries countriesSize |

	"countries := self currentSystem geographyModule countries.
	countriesSize := countries collectionSize."

	country := self newCountry.
	country 
		formalName: 'Republic of Xxxxx';
		commonName: 'Xxxxx';
		isoCode: 'XX';
		isoCode3: 'XXX';
		subdivisionName: 'Province';
		isoNumber: '123'.
		
	self assert: country formalName equals: 'Republic of Xxxxx'.
	self assert: country commonName equals: 'Xxxxx'.
	self assert: country isoCode equals: 'XX'.
	self assert: country isoCode3 equals: 'XXX'.
	self assert: country subdivisionName equals: 'Province'.
	self assert: country isoNumber equals: '123'.
	self assert: country postalCodeClass = LcsGenericPostalCode.
	self assert: country subdivisionClass = LcsCountrySubdivision.

	"self currentSystem currentUnitOfWork applyChanges."
	
	"self assert: countries pendingAdds size equals: countriesSize + 1.
	self assert: (countries includes: country)."
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
LcsCountryExamples >> newCountryWithCanadaPostalCode [
	<gtExample>
	| country |
	country := self newCountry.
	self assert: country postalCodeClass = LcsGenericPostalCode.
	country postalCodeClass: LcsZipCode.
	self assert: country postalCodeClass = LcsZipCode.
	country postalCodeClass: LcsCanadaPostalCode.
	self assert: country postalCodeClass = LcsCanadaPostalCode.
	^ country
]

{ #category : 'examples' }
LcsCountryExamples >> newCountryWithFailedAttemptToChangePostCodeClass [
	<gtExample>
	| country originalValue |
	country := self newCountry.
	originalValue := country postalCodeClass.
	self should: [ country postalCodeClass: 'xxx' ] raise: LcsInvalidSlotTypeError.
	"self assert: self currentUnitOfWork hasChanges not."
	self assert: country postalCodeClass equals: originalValue.
	^ country
]

{ #category : 'examples' }
LcsCountryExamples >> newCountryWithUnitedStatesSubdivision [
	<gtExample>
	| country |
	country := self newCountry.
	self assert: country subdivisionClass = LcsCountrySubdivision.
	country subdivisionClass: LcsCanadaSubdivision.
	self assert: country subdivisionClass = LcsCanadaSubdivision.
	country subdivisionClass: LcsUnitedStatesSubdivision.
	self assert: country subdivisionClass = LcsUnitedStatesSubdivision.
	^ country
]

{ #category : 'examples' }
LcsCountryExamples >> unknownCountry [
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
