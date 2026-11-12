Class {
	#name : 'LuiMainMenu',
	#superclass : 'LuiMenu',
	#category : 'Lcs-WebComponents-Menus',
	#package : 'Lcs-WebComponents',
	#tag : 'Menus'
}

{ #category : 'defaults' }
LuiMainMenu >> defaultCssClasses [
	^ OrderedCollection with: LuiCssClassesMap / #'nav-links'
]

{ #category : 'inititalize' }
LuiMainMenu >> initialize [
	super initialize.
	self componentName: 'mainMenu'
]
