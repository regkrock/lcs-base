Class {
	#name : 'LuiNumberInputExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'as yet unclassified' }
LuiNumberInputExamples >> newComponent [
	<gtExample>
	| component expectedHtml |
	component := LuiNumberInput new.
	expectedHtml := '<input data-StClass="LuiNumberInput" value="" type="number"/>'.
	self assertRendered: component equals: expectedHtml. 
	^ component
]

{ #category : 'as yet unclassified' }
LuiNumberInputExamples >> newNamedComponent [
	<gtExample>
	| component expectedHtml |
	component := LuiNumberInput named: 'xxx'.
	self assert: component displayValue equals: ''.
	expectedHtml := '<input data-name="xxx" data-StClass="LuiNumberInput" name="1" value="" type="number"/>'.
	self assertRendered: component equals: expectedHtml.
	^ component
]

{ #category : 'examples' }
LuiNumberInputExamples >> numberInputForInteger_PersonWeight [
	<gtExample>
	<after: #clearUnitOfWork>
	| component person|
	self ensureCurrentSystemIsPrototypeSystem.
	person := LxxPersonExamples new johnFreeman.
	component := LuiNumberInput onSlotNamed: 'weight' model: person.
	self assert: component step equals: 1.
	self assert: component displayValue equals: '180'.
	self assertRendered: component equals: '<input data-name="weight" data-StClass="LuiNumberInput" step="1" max="500" min="0" name="1" value="180" type="number"/>'.
	^ component
]
