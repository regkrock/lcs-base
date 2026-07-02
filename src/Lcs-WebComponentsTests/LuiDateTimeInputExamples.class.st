Class {
	#name : 'LuiDateTimeInputExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiDateTimeInputExamples >> componentWithMinMaxAndDefaultStep [
	<gtExample>
	| component  begin end expectedHtml|
	begin := DateAndTime fromString: '2026-06-27T00:00'.
	end := DateAndTime fromString: '2026-06-28T23:59'.
	component := self newComponent.
	component min: begin.
	component max: end.
	expectedHtml := '<input data-name="dateTimePicker" data-StClass="LuiDateTimeInput" max="2026-06-28T23:59:00-04:00" min="2026-06-27T00:00:00-04:00" name="1" value="2026-06-27T12:00:00-04:00" type="datetime"/>'.
	self assertRendered: component equals: expectedHtml.
	^ component
]

{ #category : 'examples' }
LuiDateTimeInputExamples >> componentWithMinMaxAndStep [
	<gtExample>
	| component  begin end expectedHtml|
	begin := DateAndTime fromString: '2026-06-27T00:00'.
	end := DateAndTime fromString: '2026-06-28T23:59'.
	component := self newComponent.
	component min: begin.
	component max: end.
	component step: 1.
	expectedHtml := '<input data-name="dateTimePicker" data-StClass="LuiDateTimeInput" max="2026-06-28T23:59:00-04:00" step="1" min="2026-06-27T00:00:00-04:00" name="1" value="2026-06-27T12:00:00-04:00" type="datetime"/>'.
	self assertRendered: component equals: expectedHtml.
	^ component
]

{ #category : 'examples' }
LuiDateTimeInputExamples >> newComponent [
	<gtExample>
	| component expectedHtml timestamp |
	timestamp := DateAndTime fromString: '2026-06-27T12:00'.
	component := LuiDateTimeInput named: 'dateTimePicker' model: timestamp.
	self assert: component min isNil.
	self assert: component max isNil.
	self assert: component step isNil.

	expectedHtml := '<input data-name="dateTimePicker" data-StClass="LuiDateTimeInput" name="1" value="' , timestamp asString , '" type="datetime"/>'.
	self assertRendered: component equals: expectedHtml.

	^ component
]

{ #category : 'examples' }
LuiDateTimeInputExamples >> personCreatedTimestampInputComponent [
	<gtExample>
	<after: #clearUnitOfWork>
	| component person |
	self ensureCurrentSystemIsPrototypeSystem.
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
