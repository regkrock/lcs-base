Class {
	#name : #LuiSwapApplicationAreaTest,
	#superclass : #LuiFunctionalTest,
	#category : #'Lcs-WebComponentsTests-Functional'
}

{ #category : #initialize }
LuiSwapApplicationAreaTest class >> browserTabName [
	^ 'Seas Monmouth'
]

{ #category : #initialize }
LuiSwapApplicationAreaTest class >> initialize [
	WAAdmin register: self asApplicationAt: self browserTabName
]

{ #category : #menus }
LuiSwapApplicationAreaTest class >> menuBarDefinition [
	| menuDefinition |
	menuDefinition := LcsMainMenuDefinition new.
	menuDefinition
		addMenuComponentDefintion: (LcsMenuItemDefinition new
			menuItemLabel: 'Home';
			targetClass: LuiHomeArea;
			yourself);
		addMenuComponentDefintion: (LcsMenuItemDefinition new
			menuItemLabel: 'Members';
			targetClass: LuiMember;
			yourself);
		addMenuComponentDefintion: (LcsMenuItemDefinition new
			menuItemLabel: 'Skippers';
			targetClass: LuiSkippers;
			yourself).
	^menuDefinition

]

{ #category : #setup }
LuiSwapApplicationAreaTest >> addMainNavigationMenuTo: aMainMenu [
	aMainMenu buildFrom: self menuDefinition
]

{ #category : #initialize }
LuiSwapApplicationAreaTest >> initialize [
	| mainPage |
	super initialize.
	self componentName: 'root'.
	self componentId: 'root'.
	self addComponent: (mainPage := LuiMainPage named: 'mainPage' on: self).

	self addMainNavigationMenuTo: (mainPage componentNamed: 'header/navigation').
	(mainPage componentNamed: 'header/title') domainObject: 'Swap Application Area'.

]

{ #category : #setup }
LuiSwapApplicationAreaTest >> menuDefinition [
	^ self class menuBarDefinition
]

{ #category : #rendering }
LuiSwapApplicationAreaTest >> renderComponentOn: html [
	html div 
		addCommonProperties: self;
		with: [
			self renderSubcomponentsOn: html ]
]

{ #category : #updating }
LuiSwapApplicationAreaTest >> updateRoot: aRoot [

	super updateRoot: aRoot.
	aRoot stylesheet url: LcsFunctionalTestFileLibrary / #mainCss
]
