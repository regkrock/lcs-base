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
	WAAdmin register: self asApplicationAt: self browserTabName.
	WAAdmin applicationDefaults removeParent: WADevelopmentConfiguration instance
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
LuiSwapApplicationAreaFunctionalTest >> addNavigationMenuTo: aNavigationMenu [
	aNavigationMenu buildFrom: self menuDefinition
]

{ #category : 'initialize' }
LuiSwapApplicationAreaFunctionalTest >> initialize [
	| mainPage |
	super initialize.
	self componentName: 'root'.
	self componentId: 'root'.
	self addComponent: (mainPage := LuiFunctionalTestsMainPage new).

	self addNavigationMenuTo: mainPage navigationBar navigationMenu.
	mainPage pageTitleComponent text: 'Swap Application Area'.

]

{ #category : 'setup' }
LuiSwapApplicationAreaFunctionalTest >> menuDefinition [
	^ self class menuBarDefinition
]
