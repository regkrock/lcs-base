Class {
	#name : 'LuiSubmenu',
	#superclass : 'LuiMenuObject',
	#instVars : [
		'label'
	],
	#category : 'Lcs-WebComponents-Menus',
	#package : 'Lcs-WebComponents',
	#tag : 'Menus'
}

{ #category : 'building' }
LuiSubmenu >> buildFrom: aSubmenuDefinition [
	self label: aSubmenuDefinition label.
	aSubmenuDefinition menuComponentDefintions do: [ :eachMenuDefinition  | 
		| menuComponent |
		menuComponent := eachMenuDefinition componentClass named: eachMenuDefinition componentName on: self.
		self addComponent: menuComponent.
		menuComponent buildFrom: eachMenuDefinition]
]

{ #category : 'rendering' }
LuiSubmenu >> buildSubmenuCssClassName: aString [ 
	^ (self parentComponent buildSubmenuCssClassName: aString) , 'sub'
]

{ #category : 'initialize' }
LuiSubmenu >> cssMenuClassName [
	self parentComponent class = LuiNavigationMenu ifTrue: [ ^ 'mainMenuItem' ].
	^ 'submenuItem' 
]

{ #category : 'defaults' }
LuiSubmenu >> defaultCssClasses [
	^OrderedCollection with: 'submenu'
]

{ #category : 'initialize' }
LuiSubmenu >> initializeNamed: aName on: aWebComponent [
	super initializeNamed: aName on: aWebComponent.
	self cssClassesAttribute
		replaceExistingCssClassesWithCssClass: self cssMenuClassName
]

{ #category : 'accessing' }
LuiSubmenu >> label [
	^ label
]

{ #category : 'accessing' }
LuiSubmenu >> label: anObject [
	label := anObject
]

{ #category : 'rendering' }
LuiSubmenu >> renderComponentOn: html [
	html listItem
		addCommonAttributes: self;
		with: [ html text: self label.
			html unorderedList
				class: self submenuCssClass;
				with: [ self renderSubcomponentsOn: html ] ]
]

{ #category : 'rendering' }
LuiSubmenu >> submenuCssClass [
	^ self buildSubmenuCssClassName: ''
]
