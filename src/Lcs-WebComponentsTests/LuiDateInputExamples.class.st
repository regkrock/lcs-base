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
	| component expectedHtml person minimumDate maximumDate birthDate dateOfBirthSlot |
	self ensureCurrentSystemIsPrototypeSystem.
	dateOfBirthSlot := LxxPerson slotDefinitionNamed: 'dateOfBirth'.
	birthDate := Date
			newDay: 1
			month: 1
			year: 2026.
	maximumDate := Date today.
	minimumDate := Date
			newDay: maximumDate dayOfMonth
			month: maximumDate monthIndex
			year: maximumDate year - 120.
	person := LxxPerson new.
	person dateOfBirth: birthDate.
	component := LuiDateInput onSlotNamed: 'dateOfBirth' model: person.
	self assert: dateOfBirthSlot minimum equals: minimumDate.
	self assert: dateOfBirthSlot maximum equals: maximumDate.


	expectedHtml := '<input data-name="dateOfBirth" data-StClass="LuiDateInput" name="dateOfBirth" min="'
			, minimumDate yyyymmdd , '" max="' , maximumDate yyyymmdd , '" value="'
			, birthDate yyyymmdd , '" type="date"/>'.

	self assertRendered: component equals: expectedHtml.

	^ component
]

{ #category : 'examples' }
LuiDateInputExamples >> newComponent [
	<gtExample>
	| component expectedHtml today |
	today := Date today yyyymmdd.
	component := LuiDateInput named: 'datePicker' model: Date today.
	
	expectedHtml := '<input data-name="datePicker" data-StClass="LuiDateInput" name="datePicker" value="' , today , '" type="date"/>'.
	self assertRendered: component equals: expectedHtml.

	^ component
]
