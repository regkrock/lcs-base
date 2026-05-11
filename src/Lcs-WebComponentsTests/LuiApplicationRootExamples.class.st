Class {
	#name : 'LuiApplicationRootExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiApplicationRootExamples >> htmlForComponent [
	<gtExample>
	| expectedHtml |
	expectedHtml := '<div id="root" name="root" data-StClass="LuiApplicationRoot"></div>'.
	^ self
		assertRenderNewComponentEquals: expectedHtml
]

{ #category : 'examples' }
LuiApplicationRootExamples >> newComponent [
	<gtExample>
	| component |
	component := LuiApplicationRoot new.
	self assert: component componentName = 'root'.
	self assert: component componentId = 'root'.
	self assert: component hasNoComponents.
	^ component
]

{ #category : 'examples' }
LuiApplicationRootExamples >> rootWithMainPage [
	<gtExample>
	| root mainPageComponent |
	root := self newComponent.
	mainPageComponent := root addComponent: (LuiMainPageExamples new mainPage).
	self assert: mainPageComponent parentComponent equals: root.
	^ root
]
