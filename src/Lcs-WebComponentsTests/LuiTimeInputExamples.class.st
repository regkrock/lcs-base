Class {
	#name : 'LuiTimeInputExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiTimeInputExamples >> newComponent [
	<gtExample>
	| component expectedHtml timeNow |
	timeNow := Time now.
	component := LuiTimeInput named: 'timePicker' model: timeNow.
	self assert: component fromStringConverter class equals: LuiStringToTimeConverter.
	self assert: component toStringConverter class equals: LuiTimeToStringConverter.

	expectedHtml := '<input data-name="timePicker" data-StClass="LuiTimeInput" name="1" value="' , timeNow asString , '" type="time"/>'.
	self assertRendered: component equals: expectedHtml.
	^ component
]

{ #category : 'examples' }
LuiTimeInputExamples >> timeInputForSlotWithMinimumAndMaximum [
	<gtExample>
	<after: #clearUnitOfWork>
	| component expectedHtml person slot newTime |
	self ensureCurrentSystemIsPrototypeSystem.
	newTime := (Time midnight addSeconds: 3).
	person := LxxPerson new.
	slot := LxxPerson slotDefinitionNamed: 'time'.
	component := LuiTimeInput onSlotNamed: 'time' model: person.
	self assert: slot minimum equals: Time midnight.
	self assert: slot maximum equals: Time noon.
	self assert: slot validationRules collection size = 1 .
	self assert: slot validationRules collection any class == LcsRangeRule.

	expectedHtml := '<input data-name="time" data-StClass="LuiTimeInput" name="1" min="12:00 am" max="12:00 pm" value="' , Time midnight asString , '" type="time"/>'.
	self assertRendered: component equals: expectedHtml.
	^ component
]

{ #category : 'examples' }
LuiTimeInputExamples >> updateTime [
	<gtExample>
	<after: #clearUnitOfWork>
	| component newTime expectedHtml |
	self ensureCurrentSystemIsPrototypeSystem.
	newTime := (Time midnight addSeconds: 3).
	component := self timeInputForSlotWithMinimumAndMaximum.
	component handleCallbackValue: newTime asString.
	self assert: component model time equals: newTime.
	expectedHtml := '<input data-name="time" data-StClass="LuiTimeInput" name="1" min="12:00 am" max="12:00 pm" value="12:00:03 am" type="time"/>'.
	self assertRendered: component equals: expectedHtml.
	^ component
]

{ #category : 'examples' }
LuiTimeInputExamples >> updateTimeWithInvalidValue [
	<gtExample>
	<after: #clearUnitOfWork>
	| component newTime |
	self ensureCurrentSystemIsPrototypeSystem.
	newTime := (Time noon addSeconds: 3).
	component := self timeInputForSlotWithMinimumAndMaximum.
	self assert: component model time equals: Time midnight.
	self should: [ component handleCallbackValue: newTime asString ] raise: LcsSlotValidationError.
	self assert: component model time equals: Time midnight.
	^ component
]
