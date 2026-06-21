Class {
	#name : 'LuiDateInputExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiDateInputExamples >> birthdayOfPerson [
	<gtExample>
	<after: #clearUnitOfWork>
	| component expectedHtml person |
	self ensureCurrentSystemIsPrototypeSystem.
	person := LxxPerson new.
	person dateOfBirth: (Date newDay: 1 month: 1 year: 2026).
	component := LuiDateInput onSlotNamed: 'dateOfBirth' model: person.
	
	expectedHtml := '<input data-name="dateOfBirth" data-StClass="LuiDateInput" name="1" value="2026-01-01" type="date"/>'.
	
	self assertRendered: component equals: expectedHtml.

	^ component
]

{ #category : 'examples' }
LuiDateInputExamples >> newComponent [
	<gtExample>
	| component expectedHtml |
	component := LuiDateInput named: 'datePicker' model: Date today.
	
	expectedHtml := '<input data-name="datePicker" data-StClass="LuiDateInput" name="datePicker" value="2026-06-20" type="date"/>'.
	self assertRendered: component equals: expectedHtml.

	^ component
]
