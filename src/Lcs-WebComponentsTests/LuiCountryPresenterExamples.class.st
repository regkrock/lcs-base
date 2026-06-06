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

	expectedHtml := '<section data-name="countryPresenter" data-StClass="LuiCountryPresenter"><input id="133384925" data-name="commonName" data-StClass="LuiTextInput" name="commonName" placeholder="Common Name" class="inputField" value="Canada" type="text"/></section>'.
	
	self assertRendered: presenter equals: expectedHtml.
	^ presenter
]
