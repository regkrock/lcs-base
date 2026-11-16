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
	| navigationBar |
	navigationBar := self newNavigationBar.
	navigationBar cssClass: LuiCssClassesMap / #'navbar'.
	navigationBar addComponent: ((LuiLabel named: 'menuToggleLabel')
							for: 'menu-toggle';
							cssClass: 'hamburger';
							text: '';
							yourself).
	navigationBar addComponent: ((LuiCheckbox named: 'menuToggle')
							assignStaticId: 'menu-toggle';
							text: '';
							yourself).
	navigationBar addComponent: LuiAnchor newSeasLogo.
	navigationBar addComponent: LuiMenuExamples new exampleNavigationMenu.
	^ navigationBar
]

{ #category : 'examples' }
LuiNavigationBarExamples >> navigationBarWithSimpleNavigationMenu [
	<gtExample>
	| menuItem menuItemButton navigationMenu navigationBar |
	navigationBar := self newNavigationBar.
	navigationMenu := navigationBar addNavigationMenuBuiltFrom: LuiNavigationMenuDefinitionExamples new navigationMenuWithThreeMenuItemDefinitions .

	self assert: navigationMenu components size = 3.
	menuItem := navigationMenu componentAtIndex: 1.
	self assert: menuItem componentName = 'homeMenuItem'.
	self assert: menuItem label = 'Home'.
	self assert: menuItem cssClassesString = 'nav-item'.
	self assert: menuItem components size = 1.
	menuItemButton := menuItem components values first.
	self assert: menuItemButton componentName = 'button'.
	self assert: menuItemButton label = 'Home'.
	^ navigationMenu
]

{ #category : 'examples' }
LuiNavigationBarExamples >> newNavigationBar [
	<gtExample>
	| component |
	component := LuiNavigationBar new.
	self assert: component components isEmpty.
	self assert: component componentId isNil.
	self assert: component componentName equals: 'navbar'.
	self assert: component parentComponent isNil.
	"self assert: component domainObject isNil."
	self assert: component cssClassesString equals: LuiCssClassesMap / #navbar.
	self assert: component hasAttributes.
	^ component
]
