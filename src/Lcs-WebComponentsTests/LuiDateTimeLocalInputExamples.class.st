Class {
	#name : 'LuiDateTimeLocalInputExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiDateTimeLocalInputExamples >> newComponent [
	<gtExample>
	| component expectedHtml timestamp |
	timestamp := DateAndTime now.
	component := LuiDateTimeLocalInput named: 'dateTimeLocalPicker' model: timestamp.
	
	expectedHtml := '<input data-name="dateTimeLocalPicker" data-StClass="LuiDateTimeLocalInput" name="1" value="' , timestamp asString , '" type="datetime-local"/>'.
	self assertRendered: component equals: expectedHtml.

	^ component
]

{ #category : 'examples' }
LuiDateTimeLocalInputExamples >> personCreatedTimestampInputComponent [
	<gtExample>
	<after: #clearUnitOfWork>
	| component person |
	person := LxxPerson new.
	component := LuiDateTimeInput onSlotNamed: 'creationTimestamp' model: person.
	^ component
]

{ #category : 'examples' }
LuiDateTimeLocalInputExamples >> updateComponent [
	<gtExample>
	| component timestampString |
	timestampString := '2025-06-26T10:50:03.897789-04:00'.
	component := self newComponent.
	component handleCallbackValue: timestampString.
	self assert: component model printString equals: timestampString.
	^ component
]
