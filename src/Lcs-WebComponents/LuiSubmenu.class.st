Class {
	#name : 'LuiSubmenu',
	#superclass : 'LuiMenu',
	#category : 'Lcs-WebComponents-Menus',
	#package : 'Lcs-WebComponents',
	#tag : 'Menus'
}

{ #category : 'defaults' }
LuiSubmenu >> defaultCssClasses [
	^ OrderedCollection with: LuiCssClassesMap / #'submenu'
]
