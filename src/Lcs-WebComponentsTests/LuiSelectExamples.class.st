Class {
	#name : 'LuiSelectExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiSelectExamples >> newComponent [
	<gtExample>
	| component expectedHtml |
	expectedHtml := '<select data-name="selectComponent" data-StClass="LuiSelect" name="selectComponent"></select>'.
	component := LuiSelect named: 'selectComponent'.
	self assert: component components isEmpty.
	self assert: component parentComponent isNil.
	self assert: component componentName equals: 'selectComponent'.
	self assert: component componentId equals: nil.
	self deny: component hasLabelComponent.
	self assertRendered: component equals: expectedHtml.
	^ component
]

{ #category : 'examples' }
LuiSelectExamples >> selectWithFourOptions [
	<gtExample>
	| component expectedHtml |
	expectedHtml := '<select data-name="selectComponent" data-StClass="LuiSelect" name="selectComponent"></select>'.
	component := LuiSelect named: 'selectComponent'.
	component addOptionsFrom: #(volvo volkswagen mercedes audi).
	"self assert: component components isEmpty.
	self assert: component parentComponent isNil.
	self assert: component componentName equals: 'selectComponent'.
	self assert: component componentId equals: nil.
	self deny: component hasLabelComponent.
	self assertRendered: component equals: expectedHtml."
	^ component
]
