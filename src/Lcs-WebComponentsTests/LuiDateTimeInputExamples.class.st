Class {
	#name : 'LuiDateTimeInputExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiDateTimeInputExamples >> newComponent [
	<gtExample>
	| component expectedHtml timestamp |
	timestamp := DateAndTime now.
	component := LuiDateTimeInput named: 'dateTimePicker' model: timestamp.
	
	expectedHtml := '<input data-name="dateTimePicker" data-StClass="LuiDateTimeInput" name="1" value="' , timestamp asString , '" type="datetime"/>'.
	self assertRendered: component equals: expectedHtml.

	^ component
]

{ #category : 'examples' }
LuiDateTimeInputExamples >> personCreatedTimestampInputComponent [
	<gtExample>
	<after: #clearUnitOfWork>
	| component person |
	person := LxxPerson new.
	component := LuiDateTimeInput onSlotNamed: 'creationTimestamp' model: person.
	^ component
]

{ #category : 'examples' }
LuiDateTimeInputExamples >> updateComponent [
	<gtExample>
	| component timestampString |
	timestampString := '2025-06-26T10:50:03.897789-04:00'.
	component := self newComponent.
	component handleCallbackValue: timestampString.
	self assert: component model printString equals: timestampString.
	^ component
]
