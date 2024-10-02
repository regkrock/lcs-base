Class {
	#name : #LuiExampleRootComponentTest,
	#superclass : #TestCase,
	#category : #'Lcs-WebComponentsTests-Tests'
}

{ #category : #'as yet unclassified' }
LuiExampleRootComponentTest >> testExampleRootComponent [
	| root mainPage navBar submenu subsubmenu |
	root := LuiExampleRootComponent new.
	mainPage := root componentNamed: 'mainPage'.
	self assert: (mainPage isKindOf: LuiExampleMainPage).
	navBar := mainPage componentNamed: 'navigation'.
	self assert: (navBar isKindOf: LuiMainMenu).
	self assert: navBar componentName = 'navigation'.
	
	self assert: navBar components size = 3.
	submenu := navBar componentAtIndex: 1.
	self assert: submenu componentName = 'menu1'.
	self assert: submenu menuItemLabel = 'Menu 1'.
	self assert: submenu components size = 3.
	self assert: (submenu componentAtIndex: 1) componentName equals: 'menu1Item1'.
	self assert: (submenu componentAtIndex: 1) menuItemLabel equals: 'Menu 1 Item 1'.
	self assert: (submenu componentAtIndex: 2) componentName equals: 'menu1Item2'.
	self assert: (submenu componentAtIndex: 2) menuItemLabel equals: 'Menu 1 Item 2'.
	self assert: (submenu componentAtIndex: 3) componentName equals: 'menu1Item3'.
	self assert: (submenu componentAtIndex: 3) menuItemLabel equals: 'Menu 1 Item 3'.
	
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
