Class {
	#name : 'LuiDateTimeLocalInputExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiDateTimeLocalInputExamples >> componentWithMinMaxAndStep [
	<gtExample>
	| component  begin end expectedHtml|
	begin := DateAndTime fromString: '2026-06-27T00:00'.
	end := DateAndTime fromString: '2026-06-28T23:59'.
	component := self newComponent.
	component min: begin.
	component max: end.
	component step: 1.
	expectedHtml := '<input data-name="dateTimePicker" data-StClass="LuiDateTimeLocalInput" step="1" name="1" max="2026-06-28T23:59:00-04:00" min="2026-06-27T00:00:00-04:00" value="2026-06-27T12:00:00-04:00" type="datetime"/>'.
	"self assertRendered: component equals: expectedHtml."
	^ component
]

{ #category : 'examples' }
LuiDateTimeLocalInputExamples >> newComponent [
	<gtExample>
	| component expectedHtml timestamp |
	timestamp := DateAndTime fromString: '2026-06-27T12:00'.
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
