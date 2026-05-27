Class {
	#name : 'LuiSwapApplicationAreaFunctionalTest',
	#superclass : 'LuiFunctionalTest',
	#category : 'Lcs-WebComponentsTests-Functional',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Functional'
}

{ #category : 'initialize' }
LuiSwapApplicationAreaFunctionalTest class >> browserTabName [
	^ 'Seas Monmouth'
]

{ #category : 'initialize' }
LuiSwapApplicationAreaFunctionalTest class >> initialize [
	WAAdmin register: self asApplicationAt: self browserTabName
]

{ #category : 'menus' }
LuiSwapApplicationAreaFunctionalTest class >> menuBarDefinition [
	| menuDefinition |
	menuDefinition := LuiNavigationMenuDefinition new.
	menuDefinition
		addDefinition: (LuiMenuItemDefinition new
			label: 'Home';
			targetClass: LuiHomeArea;
			yourself);
		addDefinition: (LuiMenuItemDefinition new
			label: 'Members';
			targetClass: LuiMember;
			yourself).
"		addDefinition: (LuiMenuItemDefinition new
			label: 'Skippers';
			targetClass: LuiSkippers;
			yourself)."
	^menuDefinition

]

{ #category : 'setup' }
LuiSwapApplicationAreaFunctionalTest >> addMainNavigationMenuTo: aMainMenu [
	aMainMenu buildFrom: self menuDefinition
]

{ #category : 'initialize' }
LuiSwapApplicationAreaFunctionalTest >> initialize [
	| mainPage |
	super initialize.
	self componentName: 'root'.
	self componentId: 'root'.
	self addComponent: (mainPage := LuiMainPage named: 'mainPage').

	self addMainNavigationMenuTo: (mainPage componentNamed: 'navBar/navigation').
	(mainPage componentNamed: 'header/title') text: 'Swap Application Area'.

]

{ #category : 'setup' }
LuiSwapApplicationAreaFunctionalTest >> menuDefinition [
	^ self class menuBarDefinition
]
