Class {
	#name : 'LuiDomainPresenterExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'examples' }
LuiDomainPresenterExamples >> newPresenter [
	<gtExample>
	| presenter |
	presenter := LuiDomainPresenter named:'examplePresenter'.
	self assert: presenter class == LuiDomainPresenter.
	self assert: presenter componentName equals: 'examplePresenter'.
	^ presenter
]

{ #category : 'examples' }
LuiDomainPresenterExamples >> newPresenterOnExistingCountry [
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
LuiDomainPresenterExamples >> presenterWithLabelAndStringInputWidget [
	<gtExample>
	| presenter country textInputWidget labelWidget expectedHtml |
	
	expectedHtml := '<section data-name="examplePresenter" data-StClass="LuiDomainPresenter"><label id="196920081" data-name="commonNameLabel" data-StClass="LuiLabel" for="commonName">Common Name</label><input id="136161413" data-name="commonName" data-StClass="LuiTextInput" name="commonName" value="Canada" type="text"/></section>'.
	
	presenter := self newPresenterOnExistingCountry.
	country := presenter model.
	labelWidget := LuiLabel onSlot: (presenter model slotDefinitionNamed: 'commonName').
	textInputWidget := LuiTextInput onSlot: (presenter model slotDefinitionNamed: 'commonName').
	presenter addComponent: labelWidget.
	presenter addComponent: textInputWidget.
	
	self assertRendered: presenter equals: expectedHtml.

	^ presenter
]

{ #category : 'examples' }
LuiDomainPresenterExamples >> presenterWithLabelWidget [
	<gtExample>
	| presenter country labelWidget expectedHtml |
	
	expectedHtml := '<section data-name="examplePresenter" data-StClass="LuiDomainPresenter"><label id="196920081" data-name="commonNameLabel" data-StClass="LuiLabel" for="commonName">Common Name</label></section>'.
	
	presenter := self newPresenterOnExistingCountry.
	country := presenter model.
	labelWidget := LuiLabel onSlot: (presenter model slotDefinitionNamed: 'commonName').
	presenter addComponent: labelWidget.
	self assert: labelWidget myParentPresenterComponent == presenter.
	self assert: labelWidget text equals: 'Common Name'.
	
	self assertRendered: presenter equals:expectedHtml.
	
	^ presenter
]

{ #category : 'examples' }
LuiDomainPresenterExamples >> presenterWithStringInputWidget [
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
