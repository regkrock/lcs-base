Class {
	#name : #LuiMainMenu,
	#superclass : #LuiMenuObject,
	#instVars : [
		'menuItems'
	],
	#category : #'Lcs-WebComponents-Menus'
}

{ #category : #configuration }
LuiMainMenu >> beAnchor [
	self addComponent: (LuiAnchor named: 'button' on: self)
]

{ #category : #building }
LuiMainMenu >> buildFrom: aMenuComponentDefinition [
	aMenuComponentDefinition menuComponentDefintions do: [ :eachComponent | 
		| menuComponent |
		menuComponent := eachComponent componentClass named: eachComponent componentName on: self.
		self addComponent: menuComponent.
		menuComponent buildFrom: eachComponent]
]

{ #category : #'as yet unclassified' }
LuiMainMenu >> buildSubmenuCssClassName: aString [
	^ aString , 'menu'
]

{ #category : #defaults }
LuiMainMenu >> defaultCssClasses [
	^super defaultCssClasses 
		add: 'mainMenuBar';
		yourself
]

{ #category : #rendering }
LuiMainMenu >> renderComponentOn: html [
	html div
		addCommonProperties: self;
		with: [
			html unorderedList
				class: 'mainMenuBarContents';
				with: [
					self components do: [ :eachComponent | html render: eachComponent ] ] ]
		

]
