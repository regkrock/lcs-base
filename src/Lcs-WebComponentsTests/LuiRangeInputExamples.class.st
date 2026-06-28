Class {
	#name : 'LuiRangeInputExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiRangeInputExamples >> newComponent [
	<gtExample>
	| component expectedHtml |
	component := (LuiRangeInput named: 'rangeWidget' model: 5)
					min: 1;
					max: 10;
					step: 1.
	self assert: component callback printString equals: '[ :value | self handleCallbackValue: value ]'.

	expectedHtml := '<input data-name="rangeWidget" data-StClass="LuiRangeInput" max="10" step="1" min="1" name="1" value="5" type="range"/>'.
	"self assertRendered: component equals: expectedHtml."
	^ component
]

{ #category : 'examples' }
LuiRangeInputExamples >> weightRange [
	<gtExample>
	<after: #clearUnitOfWork>
	| component expectedHtml person |
	self ensureCurrentSystemIsPrototypeSystem.
	person := LxxPerson new.
	component := LuiRangeInput onSlotNamed: 'weight' model: person.

	expectedHtml := '<input data-name="weight" data-StClass="LuiRangeInput" max="500" name="1" min="0" value="0" type="range"/>'.
	self assertRendered: component equals: expectedHtml.
	^ component
]
