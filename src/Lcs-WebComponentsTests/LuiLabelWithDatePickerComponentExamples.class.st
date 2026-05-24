Class {
	#name : 'LuiLabelWithDatePickerComponentExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiLabelWithDatePickerComponentExamples >> dateOfBirthComponent [
	<gtExample>
	<after: #clearUnitOfWork>
	| component person date labelComponent inputComponent |
	date := Date newDay: 1 month: 1 year: 2000.
	person := LxxPerson new.
	person dateOfBirth: date.
	component := LuiLabelWithInputComponent onSlot: LxxPerson dateOfBirthSlotDefinition.
	component model: person.
	self assert: component componentName equals: 'dateOfBirth'.
	labelComponent := component labelComponent.
	inputComponent := component inputComponent.
	self assert: inputComponent valueAccessor slotName equals: 'dateOfBirth'.
	self assert: labelComponent labelString equals: 'Date of Birth'.
	self assert: (labelComponent isKindOf: LuiModelLabel).
	self assert: inputComponent displayValue equals: date yyyymmdd.
	self assert: (inputComponent isKindOf: LuiDatePicker).
	component model: person.
	^ component
]

{ #category : 'examples' }
LuiLabelWithDatePickerComponentExamples >> newLabelWithInputComponent [
	<gtExample>
	| component |
	component := LuiLabelWithInputComponent named: 'xxxx'.
	self assert: component hasLabelComponent.
	self assert: component labelComponent componentName equals: 'label'.
	^ component
]

{ #category : 'examples' }
LuiLabelWithDatePickerComponentExamples >> renderedDateOfBirthComponent [
	<gtExample>
	| expectedHtml |
	expectedHtml := '<div data-name="dateOfBirth" data-StClass="LuiLabelWithInputComponent"><label id="200536999" data-name="label" data-StClass="LuiModelLabel" for="dateOfBirth">Date of Birth</label><input id="26979339" data-name="input" data-StClass="LuiDatePicker" name="1" onchange="this.form.requestSubmit()" value="2000-01-01" type="date"/></div>'.
	^ self assertRendered: self dateOfBirthComponent equals: expectedHtml
]
