Class {
	#name : 'LuiRootExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiRootExamples >> htmlForNewComponent [
	<gtExample>
	^ self assertRenderNewComponentEquals: '<div id="root" name="root" data-StClass="LuiRoot"></div>'
]

{ #category : 'examples' }
LuiRootExamples >> htmlForRootWithHeader [
	<gtExample>
	| root component expectedHtml|
	expectedHtml := '<div id="root" name="root" data-StClass="LuiRoot"><header id="6011064" name="header" data-StClass="LuiPageHeader" class="pageHeader"></header></div>'.
	root := self rootWithHeader.
	^ self assertRendered: root equals: expectedHtml
]

{ #category : 'examples' }
LuiRootExamples >> newComponent [
	<gtExample>
	| component |
	component := LuiRoot new.	
	self assert: component componentName = 'root'.
	self assert: component componentId = 'root'.
	self assert: component hasNoComponents.
	^ component
]

{ #category : 'examples' }
LuiRootExamples >> rootWithHeader [
	<gtExample>
	| root headerComponent |
	root := self newComponent.
	headerComponent := root addComponent: (LuiPageHeader named: 'header').
	self assert: headerComponent parentComponent equals: root.
	^ root
]

{ #category : 'examples' }
LuiRootExamples >> rootWithMainPage [
	<gtExample>
	| root mainPageComponent |
	root := self newComponent.
	mainPageComponent := root addComponent: (LuiMainPageExamples new mainPage).
	self assert: mainPageComponent parentComponent equals: root.
	^ root
]
