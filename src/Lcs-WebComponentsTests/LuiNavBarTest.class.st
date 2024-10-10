Class {
	#name : #LuiNavBarTest,
	#superclass : #TestCase,
	#instVars : [
		'mainPage',
		'navBar',
		'rootComponent'
	],
	#category : #'Lcs-WebComponentsTests-Tests'
}

{ #category : #components }
LuiNavBarTest >> basicRootComponent [
	rootComponent := LuiRoot new.
	rootComponent componentName: 'root'.
	rootComponent componentId: 'root'.
	
	self assert: rootComponent componentName = 'root'.
	self assert: rootComponent componentId = 'root'.
	self assert: rootComponent hasNoComponents.
	^ rootComponent
]

{ #category : #'menu definitions' }
LuiNavBarTest >> menuBarWithSubSubMenuDefinition [
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

{ #category : #'menu definitions' }
LuiNavBarTest >> menuBarWithThreeMenuItems [
	| menuDefinition |
	menuDefinition := LcsMainMenuDefinition new.
	menuDefinition
		addMenuComponentDefintion: (
			LcsMenuItemDefinition new 
				menuItemLabel: 'Home';
				beAnchor;
				title: 'abc';
				yourself);
		addMenuComponentDefintion: (LcsMenuItemDefinition new menuItemLabel: 'Contadt');
		addMenuComponentDefintion: (LcsMenuItemDefinition new menuItemLabel: 'About').
	^ menuDefinition
]

{ #category : #'as yet unclassified' }
LuiNavBarTest >> rootComponentWithMainPageWithHeaderAndEmptyNavBar [
	self basicRootComponent.

	rootComponent addComponent: (mainPage := LuiMainPage named: 'mainPage' on: rootComponent).
	mainPage pageTitleComponent domainObject: 'LCS Example'.
	mainPage := rootComponent componentNamed: 'mainPage'.

	self assert: (mainPage isKindOf: LuiMainPage).
	self assert: ((navBar := mainPage navigationBar) isKindOf: LuiMainMenu).
	self assert: navBar hasNoComponents.
	self assert: (mainPage pageTitleComponent isKindOf: LuiHeading).
	self assert: mainPage navigationBar componentName = 'navigation'.
	^ rootComponent
]

{ #category : #utilities }
LuiNavBarTest >> testNavBarMenuCreation [
	<example>
	| submenu subsubmenu |
	rootComponent := self rootComponentWithMainPageWithHeaderAndEmptyNavBar.
	navBar buildFrom: self menuBarWithSubSubMenuDefinition.

	self assert: navBar components size = 3.
	submenu := navBar componentAtIndex: 1.
	self assert: submenu componentName = 'menu1'.
	self assert: submenu menuItemLabel = 'Menu 1'.
	self assert: submenu cssClassesString equals: 'submenuItem'.
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
	self assert: subsubmenu menuItemLabel = 'Menu 3 Item 2'
]

{ #category : #'as yet unclassified' }
LuiNavBarTest >> testSimpleNavBar [
	<example>
	| menuItem menuItemButton |
	rootComponent := self rootComponentWithMainPageWithHeaderAndEmptyNavBar.
	navBar buildFrom: self menuBarWithThreeMenuItems.

	self assert: navBar components size = 3.
	menuItem := navBar componentAtIndex: 1.
	self assert: menuItem componentName = 'home'.
	self assert: menuItem menuItemLabel = 'Home'.
	self assert: menuItem cssClassesString = 'mainMenuItem'.
	self assert: menuItem components size = 1.
	menuItemButton := menuItem components values first.
	self assert: menuItemButton componentName = ''
]
