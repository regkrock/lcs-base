Class {
	#name : 'LuiRootExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiRootExamples >> newRoot [
	<gtExample>
	| component |
	component := LuiRoot new.
	component componentName: 'root'.
	component componentId: 'root'.
	
	self assert: component componentName = 'root'.
	self assert: component componentId = 'root'.
	self assert: component hasNoComponents.
	^ component
]

{ #category : 'examples' }
LuiRootExamples >> renderedComponent [
	<gtExample>
	| component expectedHtml |
	expectedHtml := '<div id="root" data-name="root" data-StClass="LuiRoot"></div>'.
	component := self newRoot.
	self
		assert: [ :html | html render: component ]
		gives: expectedHtml.
	^ expectedHtml
]

{ #category : 'examples' }
LuiRootExamples >> rootWithMainPage [
	<gtExample>
	| root mainPageComponent |
	root := self newRoot.
	mainPageComponent := root addComponent: (LuiMainPageExamples new mainPage).
	self assert: mainPageComponent parentComponent equals: root.
	^ root
]
