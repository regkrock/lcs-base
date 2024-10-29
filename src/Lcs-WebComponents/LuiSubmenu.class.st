Class {
	#name : #LuiSubmenu,
	#superclass : #LuiMenuObject,
	#instVars : [
		'menuItemLabel'
	],
	#category : #'Lcs-WebComponents-Menus'
}

{ #category : #building }
LuiSubmenu >> buildFrom: aSubmenuDefinition [
	self menuItemLabel: aSubmenuDefinition menuItemLabel.
	aSubmenuDefinition menuComponentDefintions do: [ :eachMenuDefinition  | 
		| menuComponent |
		menuComponent := eachMenuDefinition componentClass named: eachMenuDefinition componentName on: self.
		self addComponent: menuComponent.
		menuComponent buildFrom: eachMenuDefinition]
]

{ #category : #rendering }
LuiSubmenu >> buildSubmenuCssClassName: aString [ 
	^ (self parentComponent buildSubmenuCssClassName: aString) , 'sub'
]

{ #category : #initialize }
LuiSubmenu >> cssMenuClassName [
	self parentComponent class = LuiMainMenu ifTrue: [ ^ 'mainMenuItem' ].
	^ 'submenuItem' 
]

{ #category : #defaults }
LuiSubmenu >> defaultCssClasses [
	^OrderedCollection with: 'submenu'
]

{ #category : #initialize }
LuiSubmenu >> initializeNamed: aName on: aWebComponent [
	super initializeNamed: aName on: aWebComponent.
	self cssClassesProperty
		replaceExistingCssClassesWithCssClass: self cssMenuClassName
]

{ #category : #accessing }
LuiSubmenu >> menuItemLabel [
	^ menuItemLabel
]

{ #category : #accessing }
LuiSubmenu >> menuItemLabel: anObject [
	menuItemLabel := anObject
]

{ #category : #rendering }
LuiSubmenu >> renderComponentOn: html [
	html listItem
		addCommonProperties: self;
		with: [
			html text: self menuItemLabel.
			html unorderedList 
				class: self submenuCssClass;
				with: [
					self components do: [ :eachComponent | html render: eachComponent ] ] ]
]

{ #category : #rendering }
LuiSubmenu >> submenuCssClass [
	^ self buildSubmenuCssClassName: ''
]
