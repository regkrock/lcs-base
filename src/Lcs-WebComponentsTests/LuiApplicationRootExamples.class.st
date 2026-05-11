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
	expectedHtml := '<div id="root" name="root" data-StClass="LuiApplicationRoot"><div id="181030473" name="mainPage" data-StClass="LuiMainPage"><header id="262186886" name="header" data-StClass="LuiPageHeader" class="pageHeader"></header><div id="219367832" name="navBar" data-StClass="LuiNavigationBar"><div id="227796763" name="navigation" data-StClass="LuiNavigationMenu" class="mainMenuBar"><ul class="mainMenuBarContents"></ul></div></div><div id="258427659" name="applicationArea" data-StClass="LuiHomeArea" class="applicationArea"><p>LuiHomeArea</p><p></p></div></div></div>'.
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
	self assert: component hasComponents.
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
