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
	expectedHtml := '<input id="17819216" data-name="lastName" data-StClass="LuiTextInput" name="lastName" placeholder="Last Name" class="inputField" value="Smith" type="text"/>'.
	^ self assertRendered: self lastNameLabelWithInputComponent inputComponent equals: expectedHtml
]

{ #category : 'examples' }
LuiLabelWithInputComponentExamples >> htmlForLastNameLabel [
	<gtExample>
	| expectedHtml|
	expectedHtml := '<label id="1052112" data-name="lastNameLabel" data-StClass="LuiModelLabel" for="lastName">Last Name</label>'.
	^ self assertRendered: self lastNameLabelWithInputComponent labelComponent equals: expectedHtml
]

{ #category : 'examples' }
LuiLabelWithInputComponentExamples >> htmlForLastNameWithInLabelAndInputComponent [
	<gtExample>
	| expectedHtml|
	expectedHtml := '<div data-name="lastNameLabelAndInput" data-StClass="LuiLabelWithInputComponent"><label id="1052112" data-name="lastNameLabel" data-StClass="LuiModelLabel" for="lastName">Last Name</label><input id="17819216" data-name="lastName" data-StClass="LuiTextInput" name="lastName" placeholder="Last Name" class="inputField" value="Smith" type="text"/></div>'.
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
	component := LuiLabelWithInputComponent onSlot: LxxPerson lastNameSlotDefinition model: person.
	self assert: person lastName equals: 'Smith'.
	self assert: component componentName equals: 'lastNameLabelAndInput'.

	inputComponent := component inputComponent.
	self assert: inputComponent notNil.
	labelComponent := component labelComponent.
	self assert: labelComponent notNil.

	self assert: inputComponent componentName equals: 'lastName'.
	self assert: inputComponent valueAccessor slotName equals: 'lastName'.
	self assert: inputComponent displayValue equals: 'Smith'.
	self assert: inputComponent model equals: person.
	self assert: labelComponent componentName equals: 'lastNameLabel'.
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
	self assert: component hasNoComponents description: 'Label and Input are only created with the onSlot: method'.
	^ component
]
