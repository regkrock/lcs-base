Class {
	#name : 'LuiNavigationMenuExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiNavigationMenuExamples >> simpleNavigationMenu [
	<gtExample>
	| menuItem menuItemButton navigationMenu |
	navigationMenu := LuiNavigationMenu named: 'navigation'.
	navigationMenu buildFrom: LuiNavigationMenuDefinitionExamples new navigationMenuWithThreeMenuItemDefinitions .

	self assert: navigationMenu components size = 3.
	menuItem := navigationMenu componentAtIndex: 1.
	self assert: menuItem componentName = 'home'.
	self assert: menuItem label = 'Home'.
	self assert: menuItem cssClassesString = 'mainMenuItem'.
	self assert: menuItem components size = 1.
	menuItemButton := menuItem components values first.
	self assert: menuItemButton componentName = 'button'.
	self assert: menuItemButton label = 'Home'.
	^ navigationMenu
]
