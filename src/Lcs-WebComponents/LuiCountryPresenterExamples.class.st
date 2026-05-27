Class {
	#name : 'LuiCountryPresenterExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'examples' }
LuiCountryPresenterExamples >> newPresenter [
	<gtExample>
	| presenter |
	presenter := LuiCountryPresenter named:'countryPresenter'.
	^ presenter
]

{ #category : 'examples' }
LuiCountryPresenterExamples >> newPresenterOnExistingCountry [
	<gtExample>
	| presenter country|
	self ensureCurrentSystemIsDemoSystem.
	country := self currentSystem geographyModule countries findItemMatchingCode: 'CA'.
	presenter := self newPresenter.
	presenter domainObject: country.
	^ presenter
]
