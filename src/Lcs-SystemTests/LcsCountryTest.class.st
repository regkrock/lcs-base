Class {
	#name : #LcsCountryTest,
	#superclass : #LcsTestCase,
	#category : #'Lcs-SystemTests'
}

{ #category : #accessing }
LcsCountryTest >> testCreation [
	| country |
	self assert: LcsCountry slotDefinitions hasElements.
	country := LcsCountry new.
	country 
		countryName: 'Canada';
		isoCode: 'CA'.
		
	self assert: country countryName = 'Canada'.
	self assert: country isoCode = 'CA'.

	self currentSystem currentUnitOfWork applyChanges.
	
	self assert: (self currentSystem geographyModule countries includes: country).
]
