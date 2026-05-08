Class {
	#name : 'LuiNavigationMenu',
	#superclass : 'LuiMenuObject',
	#instVars : [
		'menuItems'
	],
	#category : 'Lcs-WebComponents-Menus',
	#package : 'Lcs-WebComponents',
	#tag : 'Menus'
}

{ #category : 'configuration' }
LuiNavigationMenu >> beAnchor [
	self addComponent: (LuiAnchor named: 'button' on: self)
]

{ #category : 'building' }
LuiNavigationMenu >> buildFrom: aNavigationMenuDefinition [
	aNavigationMenuDefinition menuComponentDefintions do: [ :eachComponent | 
		| menuComponent |
		menuComponent := eachComponent componentClass named: eachComponent componentName on: self.
		self addComponent: menuComponent.
		menuComponent buildFrom: eachComponent]
]

{ #category : 'as yet unclassified' }
LuiNavigationMenu >> buildSubmenuCssClassName: aString [
	^ aString , 'menu'
]

{ #category : 'defaults' }
LuiNavigationMenu >> defaultCssClasses [
	^super defaultCssClasses 
		add: 'mainMenuBar';
		yourself
]

{ #category : 'rendering' }
LuiNavigationMenu >> renderComponentOn: html [
	html div
		addCommonProperties: self;
		with: [ html unorderedList
				class: 'mainMenuBarContents';
				with: [ self renderSubcomponentsOn: html ] ]
]
