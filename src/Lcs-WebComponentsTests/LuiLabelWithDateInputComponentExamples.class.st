Class {
	#name : 'LuiLabelWithDateInputComponentExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiLabelWithDateInputComponentExamples >> dateOfBirthComponent [
	<gtExample>
	<after: #clearUnitOfWork>
	| component person date labelComponent inputComponent |
	self ensureCurrentSystemIsPrototypeSystem.
	date := Date newDay: 1 month: 1 year: 2000.
	person := LxxPerson new.
	person dateOfBirth: date.
	component := LuiLabelWithInputComponent onSlotNamed: 'dateOfBirth' model: person.
	self assert: component componentName equals: 'dateOfBirthLabelAndInput'.

	labelComponent := component labelComponent.
	self assert: labelComponent text equals: 'Date of Birth'.
	self assert: (labelComponent isKindOf: LuiLabel).

	inputComponent := component inputComponent.
	self assert: inputComponent valueAccessor slotName equals: 'dateOfBirth'.
	self assert: inputComponent displayValue equals: date yyyymmdd.
	self assert: (inputComponent isKindOf: LuiDateInput).
	self assert: labelComponent for equals: inputComponent componentId.

	^ component
]

{ #category : 'examples' }
LuiLabelWithDateInputComponentExamples >> newLabelWithInputComponent [
	<gtExample>
	| component |
	component := LuiLabelWithInputComponent named: 'xxxx'.
	self assert: component hasNoComponents.
	^ component
]

{ #category : 'examples' }
LuiLabelWithDateInputComponentExamples >> renderedDateOfBirthComponent [
	<gtExample>
	| expectedHtml minDate maxDate |
	maxDate := Date today.
	minDate := Date newDay: maxDate dayOfMonth month: maxDate monthIndex year: (maxDate year - 120).
	expectedHtml := '<div data-name="dateOfBirthLabelAndInput" data-StClass="LuiLabelWithInputComponent" class="labelAndInputRow"><label id="202059686" data-name="dateOfBirthLabel" data-StClass="LuiLabel" for="100825630">Date of Birth</label><input id="100825630" data-name="dateOfBirth" data-StClass="LuiDateInput" name="1" min="' , minDate yyyymmdd , '" max="' , maxDate yyyymmdd , '" value="2000-01-01" type="date"/></div>'.
	^ self assertRendered: self dateOfBirthComponent equals: expectedHtml
]
