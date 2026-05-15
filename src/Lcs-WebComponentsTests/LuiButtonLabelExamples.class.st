Class {
	#name : 'LuiButtonLabelExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiButtonLabelExamples >> newComponent [
	<gtExample>
	| component |
	component := LuiButtonLabel named: 'labelComponent'.
	self assert: component componentName equals: 'labelComponent'.
	self assert: component labelString isEmpty.
	self assertRendered: component equals: '<span name="labelComponent" data-StClass="LuiButtonLabel"></span>'.
	^ component
]
