Class {
	#name : 'LuiNavBarExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiNavBarExamples >> menuBarWithSubSubMenuDefinition [
	<gtExample>
	| menuDefinition |
	menuDefinition := LcsMainMenuDefinition new.
	menuDefinition
		addMenuComponentDefintion: (LcsSubmenuDefinition new
			menuItemLabel: 'Menu 1';
			addMenuComponentDefintion: (LcsMenuItemDefinition new menuItemLabel: 'Menu 1 Item 1');
			addMenuComponentDefintion: (LcsMenuItemDefinition new menuItemLabel: 'Menu 1 Item 2');
			addMenuComponentDefintion: (LcsMenuItemDefinition new menuItemLabel: 'Menu 1 Item 3'));
		addMenuComponentDefintion: (LcsSubmenuDefinition new
			menuItemLabel: 'Menu 2';
			addMenuComponentDefintion: (LcsMenuItemDefinition new menuItemLabel: 'Menu 2 Item 1');
			addMenuComponentDefintion: (LcsMenuItemDefinition new menuItemLabel: 'Menu 2 Item 2'));
		addMenuComponentDefintion: (LcsSubmenuDefinition new
			menuItemLabel: 'Menu 3';
			addMenuComponentDefintion: (LcsMenuItemDefinition new menuItemLabel: 'Menu 3 Item 1');
			addMenuComponentDefintion: (LcsSubmenuDefinition new
				menuItemLabel: 'Menu 3 Item 2';
				addMenuComponentDefintion: (LcsMenuItemDefinition new menuItemLabel: 'Menu 3 Item 2 Submenu Item 1');
				addMenuComponentDefintion: (LcsMenuItemDefinition new menuItemLabel: 'Menu 3 Item 2 Submenu Item 2'));
			addMenuComponentDefintion: (LcsSubmenuDefinition new
				menuItemLabel: 'Menu 3 Item 3';
				addMenuComponentDefintion: (LcsMenuItemDefinition new menuItemLabel: 'Menu 3 Item 3 Submenu Item 1');
				addMenuComponentDefintion: (LcsMenuItemDefinition new menuItemLabel: 'Menu 3 Item 3 Submenu Item 2'))).
	^ menuDefinition
]

{ #category : 'examples' }
LuiNavBarExamples >> menuBarWithThreeMenuItems [
	<gtExample>
	| menuDefinition |
	menuDefinition := LcsMainMenuDefinition new.
	menuDefinition
		addMenuComponentDefintion: (
			LcsMenuItemDefinition new 
				menuItemLabel: 'Home';
				beAnchor;
				title: 'abc';
				yourself);
		addMenuComponentDefintion: (LcsMenuItemDefinition new menuItemLabel: 'Contact');
		addMenuComponentDefintion: (LcsMenuItemDefinition new menuItemLabel: 'About').
	^ menuDefinition
]

{ #category : 'examples' }
LuiNavBarExamples >> newNavBarWithMenu [
	<gtExample>
	| submenu subsubmenu root mainPage navBar |
	root := self rootComponentWithMainPageWithHeaderAndEmptyNavBar.
	mainPage := root componentNamed: 'mainPage'.
	navBar := mainPage navigationBar.
	navBar buildFrom: self menuBarWithSubSubMenuDefinition.

	self assert: navBar components size = 3.
	submenu := navBar componentAtIndex: 1.
	self assert: submenu componentName = 'menu1'.
	self assert: submenu menuItemLabel = 'Menu 1'.
	self assert: submenu cssClassesString equals: 'mainMenuItem'.
	self assert: submenu components size = 3.
	self assert: (submenu componentAtIndex: 1) componentName equals: 'menu1Item1'.
	self
		assert: (submenu componentAtIndex: 1) menuItemLabel
		equals: 'Menu 1 Item 1'.
	self assert: (submenu componentAtIndex: 2) componentName equals: 'menu1Item2'.
	self
		assert: (submenu componentAtIndex: 2) menuItemLabel
		equals: 'Menu 1 Item 2'.
	self assert: (submenu componentAtIndex: 3) componentName equals: 'menu1Item3'.
	self
		assert: (submenu componentAtIndex: 3) menuItemLabel
		equals: 'Menu 1 Item 3'.
	submenu := navBar componentAtIndex: 2.
	self assert: submenu componentName = 'menu2'.
	self assert: submenu components size = 2.
	submenu := navBar componentAtIndex: 3.
	self assert: submenu componentName = 'menu3'.
	self assert: submenu components size = 3.
	subsubmenu := submenu componentAtIndex: 2.
	self assert: subsubmenu componentName = 'menu3Item2'.
	self assert: subsubmenu menuItemLabel = 'Menu 3 Item 2'.
	^ navBar
]

{ #category : 'examples' }
LuiNavBarExamples >> newRoot [
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
LuiNavBarExamples >> rootComponentWithMainPageWithHeaderAndEmptyNavBar [
	<gtExample>
	| root mainPage navBar |
	root := self newRoot.
	mainPage := LuiMainPage named: 'mainPage' on: root.
	root addComponent: mainPage.
	mainPage pageTitleComponent domainObject: 'LCS Example'.
	mainPage := root componentNamed: 'mainPage'.
	navBar := mainPage navigationBar.

	self assert: (mainPage isKindOf: LuiMainPage).
	self assert: (navBar isKindOf: LuiMainMenu).
	self assert: navBar hasNoComponents.
	self assert: (mainPage pageTitleComponent isKindOf: LuiHeading).
	self assert: mainPage navigationBar componentName = 'navigation'.
	^ root
]

{ #category : 'examples' }
LuiNavBarExamples >> simpleNavBar [
	<gtExample>
	| menuItem menuItemButton root navBar mainPage |
	root := self rootComponentWithMainPageWithHeaderAndEmptyNavBar.
	mainPage := root componentNamed: 'mainPage'.
	navBar := mainPage navigationBar.
	navBar buildFrom: self menuBarWithThreeMenuItems.

	self assert: navBar components size = 3.
	menuItem := navBar componentAtIndex: 1.
	self assert: menuItem componentName = 'home'.
	self assert: menuItem menuItemLabel = 'Home'.
	self assert: menuItem cssClassesString = 'mainMenuItem'.
	self assert: menuItem components size = 1.
	menuItemButton := menuItem components values first.
	self assert: menuItemButton componentName = 'button'.
	self assert: menuItemButton label = 'Home'.
	^ navBar
]
