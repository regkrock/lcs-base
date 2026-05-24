Class {
	#name : 'LuiLabelWithInputComponentExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiLabelWithInputComponentExamples >> htmlForLastNameInputComponent [
	<gtExample>
	| expectedHtml|
	expectedHtml := '<input id="185393756" data-name="input" data-StClass="LuiTextInput" name="input" value="Smith" type="text"/>'.
	^ self assertRendered: self lastNameLabelWithInputComponent inputComponent equals: expectedHtml
]

{ #category : 'examples' }
LuiLabelWithInputComponentExamples >> htmlForLastNameLabel [
	<gtExample>
	| expectedHtml|
	expectedHtml := '<label id="90515960" data-name="label" data-StClass="LuiModelLabel" for="lastName">Last Name</label>'.
	^ self assertRendered: self lastNameLabelWithInputComponent labelComponent equals: expectedHtml
]

{ #category : 'examples' }
LuiLabelWithInputComponentExamples >> htmlForLastNameWithInLabelAndInputComponent [
	<gtExample>
	| expectedHtml|
	expectedHtml := '<div data-name="lastName" data-StClass="LuiLabelWithInputComponent"><label id="90515960" data-name="label" data-StClass="LuiModelLabel" for="lastName">Last Name</label><input id="185393756" data-name="input" data-StClass="LuiTextInput" name="input" value="Smith" type="text"/></div>'.
	^ self assertRendered: self lastNameLabelWithInputComponent equals: expectedHtml
]

{ #category : 'examples' }
LuiLabelWithInputComponentExamples >> lastNameLabelWithInputComponent [
	<gtExample>
	<after: #clearUnitOfWork>
	| component person inputComponent labelComponent|
	self ensureCurrentSystemIsPrototypeSystem.
	person := LxxPerson new.
	person dateOfBirth: (Date newDay: 1 month: 1 year: 2000).
	person lastName: 'Smith'.
	component := LuiLabelWithInputComponent onSlot: LxxPerson lastNameSlotDefinition.
	component model: person.
	self assert: component componentName equals: 'lastName'.
	inputComponent := component inputComponent.
	labelComponent := component labelComponent.
	self assert: inputComponent componentName equals: 'input'.
	self assert: inputComponent valueAccessor slotName equals: 'lastName'.
	self assert: inputComponent displayValue equals: 'Smith'.
	self assert: inputComponent model equals: person.
	self assert: labelComponent componentName equals: 'label'.
	self assert: labelComponent labelString equals: 'Last Name'.
	self assert: labelComponent model equals: person.
	self assert: labelComponent forName equals: 'lastName'.
	^ component
]

{ #category : 'examples' }
LuiLabelWithInputComponentExamples >> properlyFormedComponent [
	<gtExample>
	| component |
	component := LuiLabelWithInputComponent named: 'xxxx'.
	self assert: component hasLabelComponent.
	self assert: component labelComponent componentName equals: 'label'.
	^ component
]
