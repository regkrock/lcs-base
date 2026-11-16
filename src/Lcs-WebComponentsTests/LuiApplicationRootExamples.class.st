Class {
	#name : 'LuiApplicationRootExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiApplicationRootExamples >> expectedNewComponentHtml [
	^ '%<div id="<1s>" data-name="<2s>" data-StClass="LuiApplicationRoot" class="<3s>"><4s>%</div>'
		expandMacrosWith: LuiComponent new rootComponentId
		with: LuiComponent new rootComponentName
		with: LuiComponent new rootComponentCssClassName
		with: ''
]

{ #category : 'examples' }
LuiApplicationRootExamples >> newComponent [
	<gtExample>
	| component expectedHtml |
	component := LuiApplicationRoot new.
	self assert: component componentName = LuiComponent new rootComponentName.
	self assert: component componentId = LuiComponent new rootComponentId.
	self assert: component hasNoComponents.
	expectedHtml := self expectedNewComponentHtml.
	self assertRendered: component equals: expectedHtml.
	^ component
]

{ #category : 'examples' }
LuiApplicationRootExamples >> rootWithHeader [
	<gtExample>
	| root pageHeader |
	root := self newComponent.
	pageHeader := LuiPageHeader new.
	root addComponent: pageHeader.
	
	self assert: pageHeader parentComponent equals: root.
	self assertRendered: root equals: '<div id="root" data-name="root" data-StClass="LuiApplicationRoot" class="applicationRoot"><header id="69637861" data-name="pageHeader" data-StClass="LuiPageHeader" class="pageHeader"></header></div>'.
	^ root
]

{ #category : 'examples' }
LuiApplicationRootExamples >> rootWithHeaderWithLogo [
	<gtExample>
	| root headerComponent |
	root := self rootWithHeader.
	headerComponent := root pageHeader.
	headerComponent addComponent: (LuiImage named: 'logo').
	self assertRendered: root equals: '<div id="root" data-name="root" data-StClass="LuiApplicationRoot" class="applicationRoot"><header id="69637861" data-name="pageHeader" data-StClass="LuiPageHeader" class="pageHeader"><img alt="" id="72700333" data-name="logo" data-StClass="LuiImage"/></header></div>' .
	^ root
]

{ #category : 'examples' }
LuiApplicationRootExamples >> rootWithHeaderWithMenu [
	<gtExample>
	| root |
	root := self rootWithHeader.
	root pageHeader addComponent: (LuiNavigationMenu new).
	self assertRendered: root equals: '<div id="root" data-name="root" data-StClass="LuiApplicationRoot" class="applicationRoot"><header id="69637861" data-name="pageHeader" data-StClass="LuiPageHeader" class="pageHeader"><ul id="130176486" data-name="navMenu" data-StClass="LuiNavigationMenu" class="nav-links"></ul></header></div>'.
	^ root
]

{ #category : 'examples' }
LuiApplicationRootExamples >> rootWithHeaderWithMenuThreeSubMenus [
	<gtExample>
	| root navigationMenu |
	root := self rootWithHeaderWithMenu.
	navigationMenu := root componentNamed: 'pageHeader/navMenu'.
	navigationMenu addComponent: (LuiMenuItem named: 'Home').
	navigationMenu addComponent: (LuiMenuItem named: 'Contact').
	navigationMenu addComponent: (LuiMenuItem named: 'About').
	self assertRendered: root equals: '<div id="root" data-name="root" data-StClass="LuiApplicationRoot" class="applicationRoot"><header id="69637861" data-name="pageHeader" data-StClass="LuiPageHeader" class="pageHeader"><ul id="130176486" data-name="navMenu" data-StClass="LuiNavigationMenu" class="nav-links"><li id="70179866" data-name="Home" data-StClass="LuiMenuItem" class="nav-item"></li><li id="256645049" data-name="Contact" data-StClass="LuiMenuItem" class="nav-item"></li><li id="146287112" data-name="About" data-StClass="LuiMenuItem" class="nav-item"></li></ul></header></div>'. 
	^ root
]
