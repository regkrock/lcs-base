Class {
	#name : #LcsCountryTest,
	#superclass : #LcsMainSystemTestCase,
	#category : #'Lcs-MainSystemTests'
}

{ #category : #tests }
LcsCountryTest >> testCreation [
	| country countries countriesSize|
	countries := self currentSystem geographyModule countries.
	countriesSize := countries collectionSize.
	self assert: LcsCountry slotModel hasSlotDefinitions.

	country := LcsCountry new.
	country 
		formalName: 'Xxxxx';
		isoCode: 'XX'.
		
	self assert: country formalName equals: 'Xxxxx'.
	self assert: country isoCode equals: 'XX'.

	self currentSystem currentUnitOfWork applyChanges.
	
	self assert: countries collectionSize equals: countriesSize + 1.
	self assert: (countries includes: country)
	
]
