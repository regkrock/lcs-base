Class {
	#name : #LuiSwapApplicationAreaFunctionalTest,
	#superclass : #LuiFunctionalTest,
	#category : #'Lcs-WebComponentsTests-Functional'
}

{ #category : #initialize }
LuiSwapApplicationAreaFunctionalTest class >> browserTabName [
	^ 'Seas Monmouth'
]

{ #category : #initialize }
LuiSwapApplicationAreaFunctionalTest class >> initialize [
	WAAdmin register: self asApplicationAt: self browserTabName
]

{ #category : #menus }
LuiSwapApplicationAreaFunctionalTest class >> menuBarDefinition [
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
LuiSwapApplicationAreaFunctionalTest >> addMainNavigationMenuTo: aMainMenu [
	aMainMenu buildFrom: self menuDefinition
]

{ #category : #initialize }
LuiSwapApplicationAreaFunctionalTest >> initialize [
	| mainPage |
	super initialize.
	self componentName: 'root'.
	self componentId: 'root'.
	self addComponent: (mainPage := LuiMainPage named: 'mainPage' on: self).

	self addMainNavigationMenuTo: (mainPage componentNamed: 'navBar/navigation').
	(mainPage componentNamed: 'header/title') domainObject: 'Swap Application Area'.

]

{ #category : #setup }
LuiSwapApplicationAreaFunctionalTest >> menuDefinition [
	^ self class menuBarDefinition
]

{ #category : #rendering }
LuiSwapApplicationAreaFunctionalTest >> renderComponentOn: html [
	html div 
		addCommonProperties: self;
		with: [
			self renderSubcomponentsOn: html ]
]

{ #category : #updating }
LuiSwapApplicationAreaFunctionalTest >> updateRoot: aRoot [

	super updateRoot: aRoot.
	aRoot stylesheet url: LcsFunctionalTestFileLibrary / #mainCss
]
