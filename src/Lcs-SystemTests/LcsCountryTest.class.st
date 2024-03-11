Class {
	#name : #LcsCountryTest,
	#superclass : #LcsSystemTestCase,
	#category : #'Lcs-SystemTests'
}

{ #category : #tests }
LcsCountryTest >> testCreation [
	| country |
	self assert: LcsCountry slotDefinitions hasElements.
	country := LcsCountry new.
	country 
		countryName: 'Canada';
		isoCode: 'CA'.
		
	self assert: country countryName equals: 'Canada'.
	self assert: country isoCode equals: 'CA'.

	self currentSystem currentUnitOfWork applyChanges.
	
	self assert: (self currentSystem geographyModule countries includes: country).
]
