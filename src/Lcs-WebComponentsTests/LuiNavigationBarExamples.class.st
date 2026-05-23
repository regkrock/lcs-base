Class {
	#name : 'LuiNavigationBarExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiNavigationBarExamples >> exampleNavigationBar [
	<gtExample>
	| navBar |
	navBar := self newNavBar.
	navBar componentName: 'navBar'.
	navBar cssClass: 'navBar'.
	navBar addComponent: LuiAnchor newSeasLogo.
	navBar addComponent: LuiMenuExamples new exampleNavigationMenu.
	^ navBar
]

{ #category : 'examples' }
LuiNavigationBarExamples >> navBarWithNavigationMenuBuiltFromNavigationMenuDefinition [
	"<gtExample>
	| submenu subsubmenu navBar navigationMenu |
	navBar := self newNavBar.
	navigationMenu := navBar addNavigationMenuBuiltFrom: LuiNavigationMenuDefinitionExamples new navigationMenuWith3Submenus.

	self assert: navigationMenu components size = 3.
	submenu := navigationMenu componentAtIndex: 1.
	self assert: submenu componentName = 'home'.
	self assert: submenu label = 'Home'.
	self assert: submenu cssClassesString equals: 'menuItem'.
	self assert: submenu components size = 1.
	self assert: (submenu componentAtIndex: 1) componentName equals: 'span'.
	self
		assert: (submenu componentAtIndex: 1) label
		equals: 'Menu 1 Item 1'.
	self assert: (submenu componentAtIndex: 2) componentName equals: 'menu1Item2'.
	self
		assert: (submenu componentAtIndex: 2) label
		equals: 'Menu 1 Item 2'.
	self assert: (submenu componentAtIndex: 3) componentName equals: 'menu1Item3'.
	self
		assert: (submenu componentAtIndex: 3) label
		equals: 'Menu 1 Item 3'.
	submenu := navigationMenu componentAtIndex: 2.
	self assert: submenu componentName = 'menu2'.
	self assert: submenu components size = 2.
	submenu := navigationMenu componentAtIndex: 3.
	self assert: submenu componentName = 'menu3'.
	self assert: submenu components size = 3.
	subsubmenu := submenu componentAtIndex: 2.
	self assert: subsubmenu componentName = 'menu3Item2'.
	self assert: subsubmenu label = 'Menu 3 Item 2'.
	^ navBar"
]

{ #category : 'examples' }
LuiNavigationBarExamples >> navBarWithSimpleNavigationMenu [
	<gtExample>
	| menuItem menuItemButton navigationMenu navBar |
	navBar := self newNavBar.
	navigationMenu := navBar addNavigationMenuBuiltFrom: LuiNavigationMenuDefinitionExamples new navigationMenuWithThreeMenuItemDefinitions .

	self assert: navigationMenu components size = 3.
	menuItem := navigationMenu componentAtIndex: 1.
	self assert: menuItem componentName = 'home'.
	self assert: menuItem label = 'Home'.
	self assert: menuItem cssClassesString = 'menuItem'.
	self assert: menuItem components size = 1.
	menuItemButton := menuItem components values first.
	self assert: menuItemButton componentName = 'span'.
	self assert: menuItemButton text = 'Home'.
	^ navigationMenu
]

{ #category : 'examples' }
LuiNavigationBarExamples >> newNavBar [
	<gtExample>
	| component |
	component := LuiNavigationBar named: 'navBar'.
	self assert: component components isEmpty.
	self assert: component componentId isNil.
	self assert: component componentName equals: 'navBar'.
	self assert: component parentComponent isNil.
	self assert: component domainObject isNil.
	self assert: component cssClassesString equals: 'navBar'.
	self assert: component hasAttributes.
	^ component
]
