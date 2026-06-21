Class {
	#name : 'LuiCountryPresenterExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
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
	| presenter country expectedHtml|
	presenter := self newPresenterOnExistingCountry.
	country := presenter model.
	presenter addComponent: (LuiTextInput onSlot: (presenter model slotDefinitionNamed: 'commonName') ).

	expectedHtml := '<div data-name="countryPresenter" data-StClass="LuiCountryPresenter"><input id="133384925" data-name="commonName" data-StClass="LuiTextInput" placeholder="Common Name" class="inputField" name="1" value="Canada" type="text"/></div>'.
	
	self assertRendered: presenter equals: expectedHtml.
	^ presenter
]
