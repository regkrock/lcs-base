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
	self ensureCurrentSystemIsPrototypeSystem.
	date := Date newDay: 1 month: 1 year: 2000.
	person := LxxPerson new.
	person dateOfBirth: date.
	component := LuiLabelWithInputComponent onSlot: LxxPerson dateOfBirthSlotDefinition model: person.
	self assert: component componentName equals: 'dateOfBirthLabelAndInput'.

	"component model: person.
"
	labelComponent := component labelComponent.
	self assert: labelComponent labelString equals: 'Date of Birth'.
	self assert: (labelComponent isKindOf: LuiLabel).

	inputComponent := component inputComponent.
	self assert: inputComponent valueAccessor slotName equals: 'dateOfBirth'.
	self assert: inputComponent displayValue equals: date yyyymmdd.
	self assert: (inputComponent isKindOf: LuiDatePicker).

		^ component
]

{ #category : 'examples' }
LuiLabelWithDatePickerComponentExamples >> newLabelWithInputComponent [
	<gtExample>
	| component |
	component := LuiLabelWithInputComponent named: 'xxxx'.
	self assert: component hasNoComponents.
	^ component
]

{ #category : 'examples' }
LuiLabelWithDatePickerComponentExamples >> renderedDateOfBirthComponent [
	<gtExample>
	| expectedHtml |
	expectedHtml := '<div data-name="dateOfBirthLabelAndInput" data-StClass="LuiLabelWithInputComponent"><label id="202059686" data-name="dateOfBirthLabel" data-StClass="LuiLabel" for="dateOfBirth">Date of Birth</label><input id="100825630" data-name="dateOfBirth" data-StClass="LuiDatePicker" name="1" onchange="this.form.requestSubmit()" value="2000-01-01" type="date"/></div>'.
	^ self assertRendered: self dateOfBirthComponent equals: expectedHtml
]
