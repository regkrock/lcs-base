Class {
	#name : 'LuiSelectExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiSelectExamples >> htmlForNewComponent [
	<gtExample>
	^ self assertRenderNewComponentEquals: '<select name="selectComponent" data-StClass="LuiSelect"></select>'
]

{ #category : 'examples' }
LuiSelectExamples >> newComponent [
	<gtExample>
	| component |
	component := LuiSelect named: 'selectComponent' on: nil.
	self assert: component components isEmpty.
	self assert: component parentComponent isNil.
	self assert: component componentName equals: 'selectComponent'.
	self assert: component componentId equals: nil.
	self deny: component hasLabelComponent.
	^ component
]
