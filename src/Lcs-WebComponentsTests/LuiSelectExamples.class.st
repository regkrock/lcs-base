Class {
	#name : 'LuiSelectExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiSelectExamples >> newComponent [
	<gtExample>
	| component |
	component := LuiSelect named: 'select' on: nil.
	self assert: component components isEmpty.
	self assert: component parentComponent isNil.
	self assert: component labelString equals: ''.
	^ component
]

{ #category : 'examples' }
LuiSelectExamples >> okSelectComponent [
	<gtExample>
	| component |
	component := self newComponent.
	component labelString: 'OK'.
	self assert: component components size = 1.
	self assert: component hasLabelComponent.
	self assert: component labelString equals: 'OK'.
	^ component
]

{ #category : 'examples' }
LuiSelectExamples >> renderedComponentRenderedString [
	<gtExample>
	<after: #clearUnitOfWork>
	| component person expectedHtml|
	expectedHtml := '<div data-StClass="LuiLabelWithInputComponent"><label id="218106578" data-name="label" data-StClass="LuiModelLabel" for="dateOfBirth">Date of Birth</label><input id="44548918" data-name="input" data-StClass="LuiDatePicker" name="1" onchange="this.form.requestSubmit()" value="2000-01-01" type="date"/></div>'.
	self ensureCurrentSystemIsPrototypeSystem.
	person := LxxPerson new.
	person dateOfBirth: (Date newDay: 1 month: 1 year: 2000).
	person lastName: 'Smith'.
	"component := (LuiLabelWithInputComponent named: 'dateOfBirth' on: nil)."
	component := LuiLabelWithInputComponent onSlot: (LxxPerson slotDefinitionNamed:  'dateOfBirth').
	component model: person.
	self
		assert: [ :html | html render: component ]
		gives: expectedHtml
]

{ #category : 'examples' }
LuiSelectExamples >> renderedLastNameWithInputComponentHtml [
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
