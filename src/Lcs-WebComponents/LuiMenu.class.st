Class {
	#name : 'LuiMenu',
	#superclass : 'LuiMenuObject',
	#category : 'Lcs-WebComponents-Menus',
	#package : 'Lcs-WebComponents',
	#tag : 'Menus'
}

{ #category : 'instance creastaion' }
LuiMenu class >> newMainMenu [
	^ self newMainMenuNamed: 'mainMenu'
]

{ #category : 'instance creastaion' }
LuiMenu class >> newMainMenuNamed: aComponentName [
	^ super new
		initializeMainMenuNamed: aComponentName;
		yourself
]

{ #category : 'instance creastaion' }
LuiMenu class >> newSubmenu [
	^ self newSubmenuNamed: 'submenu'
]

{ #category : 'instance creastaion' }
LuiMenu class >> newSubmenuNamed: aComponentName [
	^ super new
		initializeSubmenuNamed: aComponentName;
		yourself
]

{ #category : 'as yet unclassified' }
LuiMenu >> addNavigationMenuBuiltFrom: aMenuDefinition [
	aMenuDefinition buildNavigationMenuIn: self
]

{ #category : 'building' }
LuiMenu >> buildFrom: aNavigationMenuDefinition [
	aNavigationMenuDefinition menuComponentDefintions do: [ :eachComponent | 
		| menuComponent |
		menuComponent := eachComponent componentClass named: eachComponent componentName.
		self addComponent: menuComponent.
		menuComponent buildFrom: eachComponent]
]

{ #category : 'initialize' }
LuiMenu >> initialize [
	super initialize.
	self componentName: 'menu'.
	self cssClass: 'menu'
]

{ #category : 'initialize' }
LuiMenu >> initializeMainMenuNamed: aComponentName [
	self componentName: aComponentName.
	self cssClass: 'mainMenu'
]

{ #category : 'initialize' }
LuiMenu >> initializeSubmenuNamed: aComponentName [
	self componentName: aComponentName.
	self cssClass: 'submenu'
]

{ #category : 'rendering' }
LuiMenu >> renderComponentOn: html [
	self renderOn: html tag: html unorderedList
]
