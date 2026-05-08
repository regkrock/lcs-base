Class {
	#name : 'LuiApplicationRootExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiApplicationRootExamples >> newRoot [
	<gtExample>
	| component |
	component := LuiApplicationRoot new.
	component componentName: 'root'.
	component componentId: 'root'.
	
	self assert: component componentName = 'root'.
	self assert: component componentId = 'root'.
	self assert: component hasNoComponents.
	^ component
]

{ #category : 'examples' }
LuiApplicationRootExamples >> renderedComponent [
	<gtExample>
	| component expectedHtml |
	expectedHtml := '<div id="root" data-name="root" data-StClass="LuiApplicationRoot">Hello World</div>'.
	component := self newRoot.
	self
		assert: [ :html | html render: component ]
		gives: expectedHtml.
	^ expectedHtml
]

{ #category : 'examples' }
LuiApplicationRootExamples >> rootWithMainPage [
	<gtExample>
	| root mainPageComponent |
	root := self newRoot.
	mainPageComponent := root addComponent: (LuiMainPageExamples new mainPage).
	self assert: mainPageComponent parentComponent equals: root.
	^ root
]
