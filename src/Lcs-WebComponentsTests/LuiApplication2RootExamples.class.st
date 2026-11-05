Class {
	#name : 'LuiApplication2RootExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiApplication2RootExamples >> htmlForComponent [
	<gtExample>
	| expectedHtml |
	expectedHtml := '<div id="root" data-name="root" data-StClass="LuiApplication2Root" class="applicationRoot"></div>'.
	^ self
		assertRenderNewComponentEquals: expectedHtml
]

{ #category : 'examples' }
LuiApplication2RootExamples >> newComponent [
	<gtExample>
	| component |
	component := LuiApplication2Root new.
	self assert: component componentName = LuiComponent new rootComponentName.
	self assert: component componentId = LuiComponent new rootComponentId.
	self assert: component hasNoComponents.
	^ component
]

{ #category : 'examples' }
LuiApplication2RootExamples >> rootWithMainPage [
	<gtExample>
	| root mainPageComponent |
	root := self newComponent.
	mainPageComponent := root addComponent: (LuiMainPageExamples new mainPage).
	self assert: mainPageComponent parentComponent equals: root.
	^ root
]
