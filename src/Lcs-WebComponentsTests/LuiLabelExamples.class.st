Class {
	#name : 'LuiLabelExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiLabelExamples >> newComponent [
	<gtExample>
	| component |
	component := LuiLabel named: 'labelComponent'.
	self assert: component componentName equals: 'labelComponent'.
	self assert: component labelString isEmpty.
	self assertRendered: component equals: '<label data-name="labelComponent" data-StClass="LuiLabel"></label>'.
	^ component
]
