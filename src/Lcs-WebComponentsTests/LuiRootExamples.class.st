Class {
	#name : 'LuiRootExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiRootExamples >> newComponent [
	<gtExample>
	| component |
	component := LuiRoot new.	
	self assert: component componentName = 'root'.
	self assert: component componentId = 'root'.
	self assert: component hasNoComponents.
	self assertRendered: component equals: '<div id="root" data-name="root" data-StClass="LuiRoot"></div>'.
	^ component
]

{ #category : 'examples' }
LuiRootExamples >> rootWithHeader [
	<gtExample>
	| root headerComponent |
	root := self newComponent.
	headerComponent := LuiPageHeader named: 'header'.
	root addComponent: headerComponent.
	
	self assert: headerComponent parentComponent equals: root.
	self assertRendered: root equals: '<div id="root" data-name="root" data-StClass="LuiRoot"><header id="6011064" data-name="header" data-StClass="LuiPageHeader" class="pageHeader"></header></div>'.
	^ root
]

{ #category : 'examples' }
LuiRootExamples >> rootWithHeaderWithLogo [
	<gtExample>
	| root headerComponent |
	root := self rootWithHeader.
	headerComponent := root componentNamed: 'header'.
	headerComponent addComponent: (LuiImage named: 'logo').
	self assertRendered: root equals: '<div id="root" data-name="root" data-StClass="LuiRoot"><header id="6011064" data-name="header" data-StClass="LuiPageHeader" class="pageHeader"><img alt="" id="167883604" data-name="logo" data-StClass="LuiImage"/></header></div>' .
	^ root
]

{ #category : 'examples' }
LuiRootExamples >> rootWithHeaderWithMenu [
	<gtExample>
	| root |
	root := self rootWithHeader.
	(root componentNamed: 'header') addComponent: (LuiMenu newMainMenu).
	self assertRendered: root equals: '<div id="root" data-name="root" data-StClass="LuiRoot"><header id="6011064" data-name="header" data-StClass="LuiPageHeader" class="pageHeader"><ul id="129228857" data-name="mainMenu" data-StClass="LuiMenu" class="menu"></ul></header></div>'.
	^ root
]

{ #category : 'examples' }
LuiRootExamples >> rootWithHeaderWithMenuThreeSubMenus [
	<gtExample>
	| root mainMenu |
	root := self rootWithHeaderWithMenu.
	mainMenu := root componentNamed: 'header/mainMenu'.
	mainMenu addComponent: (LuiMenuItem named: 'Home').
	mainMenu addComponent: (LuiMenuItem named: 'Contact').
	mainMenu addComponent: (LuiMenuItem named: 'About').
	self assertRendered: root equals: '<div id="root" data-name="root" data-StClass="LuiRoot"><header id="6011064" data-name="header" data-StClass="LuiPageHeader" class="pageHeader"><ul id="129228857" data-name="mainMenu" data-StClass="LuiMenu" class="menu"><li id="55653441" data-name="Home" data-StClass="LuiMenuItem" class="menuItem"></li><li id="31059052" data-name="Contact" data-StClass="LuiMenuItem" class="menuItem"></li><li id="140848643" data-name="About" data-StClass="LuiMenuItem" class="menuItem"></li></ul></header></div>'. 
	^ root
]
