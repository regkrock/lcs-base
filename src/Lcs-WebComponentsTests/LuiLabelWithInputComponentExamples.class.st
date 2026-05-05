Class {
	#name : 'LuiLabelWithInputComponentExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiLabelWithInputComponentExamples >> lastNameLabelWithInputComponent [
	<gtExample>
	<after: #clearUnitOfWork>
	| component person |
	self ensureCurrentSystemIsPrototypeSystem.
	person := LxxPerson new.
	person dateOfBirth: (Date newDay: 1 month: 1 year: 2000).
	person lastName: 'Smith'.
	component := LuiLabelWithInputComponent onSlot: LxxPerson lastNameSlotDefinition.
	component model: person.
	self assert: component valueAccessor slotName equals: 'lastName'.
	self assert: component labelComponent labelString equals: 'Last Name'.
	self assert: component inputComponent displayValue equals: 'Smith'.
	component model: person.
	^ component
]

{ #category : 'examples' }
LuiLabelWithInputComponentExamples >> properlyFormedComponent [
	<gtExample>
	| component |
	component := LuiLabelWithInputComponent named: 'xxxx' on: nil.
	self assert: component hasLabelComponent.
	self assert: component labelComponent componentName equals: 'label'.
	^ component
]

{ #category : 'examples' }
LuiLabelWithInputComponentExamples >> renderedLastNameWithInputComponentHtml [
	<gtExample>
	| component expectedHtml|
	expectedHtml := '<div data-StClass="LuiLabelWithInputComponent"><label id="218106578" data-name="label" data-StClass="LuiModelLabel" for="lastName">Last Name</label><input id="44548918" data-name="input" data-StClass="LuiTextInput" name="lastName" value="Smith" type="text"/></div>'.
	component := self lastNameLabelWithInputComponent.
	self
		assert: [ :html | html render: component ]
		gives: expectedHtml.
	^ expectedHtml
]
