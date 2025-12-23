Class {
	#name : 'LcsCountryTest',
	#superclass : 'LcsDemoSystemRunningTestCase',
	#category : 'Lcs-GeographyTests-Tests',
	#package : 'Lcs-GeographyTests',
	#tag : 'Tests'
}

{ #category : 'tests' }
LcsCountryTest >> testCreation [
	| country countries countriesSize|
	countries := self currentSystem geographyModule countries.
	countriesSize := countries collectionSize.
	self assert: LcsCountry slotModel hasSlotDefinitions.

	country := LcsCountry new.
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

	self currentSystem currentUnitOfWork applyChanges.
	
	self assert: countries collectionSize equals: countriesSize + 1.
	self assert: (countries includes: country).
	self assert: country postalCodeClass = LcsGenericPostalCode.
	self assert: country subdivisionClass = LcsCountrySubdivision.
	
]

{ #category : 'tests' }
LcsCountryTest >> testInvalidTypeAssignment [
	| country oldValue|
	country := self currentSystem geographyModule countries defaultInstance.
	self assert: self currentUnitOfWork hasChanges not.
	oldValue := country postalCodeClass.
	self should: [ country postalCodeClass: 'xxx' ] raise: LcsInvalidSlotTypeError.
	self assert: self currentUnitOfWork hasChanges not.
	self assert: country postalCodeClass equals: oldValue
]

{ #category : 'tests' }
LcsCountryTest >> testModifyingPostalCodeClassImpactOUnitOfWork [
	| country |
	country := self currentSystem geographyModule countries defaultInstance.
	self assert: country postalCodeClass equals: LcsGenericPostalCode.
	self assert: self currentUnitOfWork hasChanges not.
	country postalCodeClass: LcsCanadaPostalCode.
	self assert: country postalCodeClass equals: LcsCanadaPostalCode.
	self assert: self currentUnitOfWork hasChanges.
	self currentSystem applyChanges.
	self assert: self currentUnitOfWork hasChanges not.
]

{ #category : 'tests' }
LcsCountryTest >> testPostalCodeAssignment [
	| country |
	country := LcsCountry new.
	self assert: country postalCodeClass = LcsGenericPostalCode.
	country postalCodeClass: LcsZipCode.
	self assert: country postalCodeClass = LcsZipCode.
	country postalCodeClass: LcsCanadaPostalCode.
	self assert: country postalCodeClass = LcsCanadaPostalCode.
]

{ #category : 'tests' }
LcsCountryTest >> testSubdivisionClassAssignment [
	| country |
	country := LcsCountry new.
	self assert: country subdivisionClass = LcsCountrySubdivision.
	country subdivisionClass: LcsCanadaSubdivision.
	self assert: country subdivisionClass = LcsCanadaSubdivision.
	country subdivisionClass: LcsUnitedStatesSubdivision.
	self assert: country subdivisionClass = LcsUnitedStatesSubdivision.
]
