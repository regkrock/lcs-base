Class {
	#name : 'LuiMenuItem',
	#superclass : 'LuiMenuObject',
	#instVars : [
		'menuItemLabel',
		'targetClass'
	],
	#category : 'Lcs-WebComponents-Menus',
	#package : 'Lcs-WebComponents',
	#tag : 'Menus'
}

{ #category : 'building' }
LuiMenuItem >> addAnchorButton: aMenuItemDefinition [
	self
		addComponent: ((LuiAnchor named: 'button' on: self)
				replaceExistingCssClassesWithCssClass: (aMenuItemDefinition buttonCssClasses ifEmpty: [ 'menuItemButton' ]);
				label: aMenuItemDefinition menuItemLabel;
				yourself)
]

{ #category : 'building' }
LuiMenuItem >> addPushButton: aMenuItemDefinition [
	| button |
	button := self addComponent: (self pushButtonFor: aMenuItemDefinition).
	"(button componentNamed: 'label')
		replaceExistingCssClassesWithCssClass: 'menuItemButtonLabel'"
]

{ #category : 'rendering' }
LuiMenuItem >> anchorClicked: aString [
	Transcript show: 'Clicked ' , aString; cr 
]

{ #category : 'building' }
LuiMenuItem >> buildFrom: aMenuItemDefinition [
	self
		menuItemLabel: aMenuItemDefinition menuItemLabel;
		targetClass: aMenuItemDefinition targetClass;
		title: aMenuItemDefinition title.
	aMenuItemDefinition isAnchor
		ifTrue: [ self addAnchorButton: aMenuItemDefinition ]
		ifFalse: [ self addPushButton: aMenuItemDefinition ]
]

{ #category : 'defaults' }
LuiMenuItem >> defaultCssClasses [
	^ OrderedCollection with: 'mainMenuItem'
]

{ #category : 'as yet unclassified' }
LuiMenuItem >> isAnchor [
	self components detect: [ :each | each class = LuiAnchor ] ifNone: [ ^ false ].
	^ true
]

{ #category : 'as yet unclassified' }
LuiMenuItem >> isPushButton [
	self components detect: [ :each | each class = LuiPushButton ] ifNone: [ ^ false ].
	^ true
]

{ #category : 'rendering' }
LuiMenuItem >> mainPage [
	^ self parentComponentNamed: 'mainPage'
]

{ #category : 'accessing' }
LuiMenuItem >> menuItemLabel [
	^ menuItemLabel
]

{ #category : 'accessing' }
LuiMenuItem >> menuItemLabel: anObject [
	menuItemLabel := anObject
]

{ #category : 'building' }
LuiMenuItem >> pushButtonFor: aMenuItemDefinition [
	| button |
	button := LuiPushButton named: 'button' on: self.
	button replaceExistingCssClassesWithCssClass: (aMenuItemDefinition buttonCssClasses ifEmpty: [ 'menuItemButton' ]).
	button label: aMenuItemDefinition menuItemLabel.
	^ button
]

{ #category : 'rendering' }
LuiMenuItem >> renderComponentOn: html [
	html listItem
		addCommonProperties: self;
		with: [ self components do: [ :eachComponent | html render: eachComponent ] ]
]

{ #category : 'accessing' }
LuiMenuItem >> targetClass [
	^ targetClass
]

{ #category : 'accessing' }
LuiMenuItem >> targetClass: anObject [
	targetClass := anObject
]
