Class {
	#name : 'LuiCountryPresenterExamples',
	#superclass : 'LuiSeasideComponentExamples',
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
	self assert: country notNil.
	presenter := self newPresenter.
	presenter model: country.
	self assert: presenter model == country.
	^ presenter
]

{ #category : 'examples' }
LuiCountryPresenterExamples >> renderedSingleColumnCountryLayout [
	<gtExample>
	| presenter country|
	presenter := self newPresenterOnExistingCountry.
	country := presenter model.
	presenter addComponent: (LuiTextInput onSlot: (presenter model slotDefinitionNamed: 'commonName') ).
	self assertRendered: presenter equals:'<section data-name="countryPresenter" data-StClass="LuiCountryPresenter"><input id="133384925" data-name="commonName" data-StClass="LuiTextInput" name="commonName" value="Canada" type="text"/></section>'.
	^ presenter
]
