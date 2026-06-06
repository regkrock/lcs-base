Class {
	#name : 'LuiCountryPresenterExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Core'
}

{ #category : 'examples' }
LuiCountryPresenterExamples >> newPresenter [
	<gtExample>
	| presenter |
	presenter := LuiCountryPresenter named:'examplePresenter'.
	self assert: presenter class == LuiCountryPresenter.
	self assert: presenter componentName equals: 'examplePresenter'.
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
	| presenter country textInputWidget|
	presenter := self newPresenterOnExistingCountry.
	country := presenter model.
	textInputWidget := LuiTextInput onSlot: (presenter model slotDefinitionNamed: 'commonName').
	presenter addComponent: textInputWidget.
	self assert: textInputWidget myParentPresenterComponent == presenter.
	
	self assertRendered: presenter equals:'<section data-name="examplePresenter" data-StClass="LuiDomainPresenter"><input id="136161413" data-name="commonName" data-StClass="LuiTextInput" name="commonName" value="Canada" type="text"/></section>'.

	^ presenter
]
