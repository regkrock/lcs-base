Class {
	#name : #LuiSelectTest,
	#superclass : #TestCase,
	#category : #'Lcs-WebComponentsTests-Tests'
}

{ #category : #'as yet unclassified' }
LuiSelectTest >> assert: aBlock gives: aString [
	| html |
	html := WAHtmlCanvas builder
		fullDocument: false;
		rootBlock: aBlock;
		render: aBlock.
	self assert: aString equals: html
]

{ #category : #setUp }
LuiSelectTest >> setupSunitSystem [
	LxxPrototypeSystem new
]

{ #category : #tests }
LuiSelectTest >> testCreation [
	| selectComponent |
	selectComponent := LuiSelect named: 'select' on: nil.
	self assert: selectComponent components isEmpty.
	self assert: selectComponent parentComponent isNil.
]

{ #category : #tests }
LuiSelectTest >> testPopulatedSelect [
	| selectComponent |
	selectComponent := (LuiSelect named: 'select' on: nil)
				labelString: 'OK';
				yourself.
	self assert: selectComponent components size = 1.
	self assert: selectComponent hasLabelComponent.
	self assert: selectComponent labelString equals: 'OK'
]

{ #category : #tests }
LuiSelectTest >> testRendering [
	| component person |
	person := LxxPerson new.
	person dateOfBirth: (Date newDay: 1 month: 1 year: 1870).
	person lastName: 'Smith'.
	component := (LuiSelect named: 'select' on: nil)
				labelString: 'OK';
				yourself.
	component model: person.
	self
		assert: [ :html | html render: component ]
		gives: 'div data-StClass="LuiLabelWithInputComponent"><label id="218106578" data-name="label" data-StClass="LuiModelLabel" for="dateOfBirth">Date of Birth</label><input id="44548918" data-name="input" data-StClass="LuiDatePicker" onchange="this.form.requestSubmit()" name="dateOfBirth" value="1870-01-01" type="date"/></div>'
]
