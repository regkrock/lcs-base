Class {
	#name : 'LuiNavigationMenu',
	#superclass : 'LuiMenu',
	#category : 'Lcs-WebComponents-Menus',
	#package : 'Lcs-WebComponents',
	#tag : 'Menus'
}

{ #category : 'defaults' }
LuiNavigationMenu >> defaultCssClasses [
	^ OrderedCollection with: LuiCssClassesMap / #'nav-links'
]

{ #category : 'inititalize' }
LuiNavigationMenu >> initialize [
	super initialize.
	self componentName: 'navMenu'
]
