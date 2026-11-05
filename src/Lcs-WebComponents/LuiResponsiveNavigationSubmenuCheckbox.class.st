Class {
	#name : 'LuiResponsiveNavigationSubmenuCheckbox',
	#superclass : 'LuiCheckbox',
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'defaults' }
LuiResponsiveNavigationSubmenuCheckbox >> defaultCssClasses [
	^ OrderedCollection with: LuiCssClassesMap / #'menu-toggle-checkbox'
]

{ #category : 'as yet unclassified' }
LuiResponsiveNavigationSubmenuCheckbox >> initialize [
	super initialize.
	self text: ''
]

{ #category : 'rendering' }
LuiResponsiveNavigationSubmenuCheckbox >> renderComponentOn: html [
	html checkbox
		addCommonAttributes: self;
		value: self valueAccessor contents == true
]
