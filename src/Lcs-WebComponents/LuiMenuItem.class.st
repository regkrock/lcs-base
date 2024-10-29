Class {
	#name : #LuiMenuItem,
	#superclass : #LuiMenuObject,
	#instVars : [
		'menuItemLabel',
		'targetClass'
	],
	#category : #'Lcs-WebComponents-Menus'
}

{ #category : #building }
LuiMenuItem >> addAnchorButton: aMenuItemDefinition [
	self
		addComponent: ((LuiAnchor named: 'button' on: self)
				replaceExistingCssClassesWithCssClass: (aMenuItemDefinition buttonCssClasses ifEmpty: [ 'menuItemButton' ]);
				label: aMenuItemDefinition menuItemLabel;
				yourself)
]

{ #category : #building }
LuiMenuItem >> addPushButton: aMenuItemDefinition [
	| button |
	button := self
		addComponent: (
			(LuiPushButton named: 'button' on: self)
				replaceExistingCssClassesWithCssClass: (aMenuItemDefinition buttonCssClasses ifEmpty: [ 'menuItemButton' ]);
				label: aMenuItemDefinition menuItemLabel;
				yourself).
	(button componentNamed: 'label') replaceExistingCssClassesWithCssClass: 'menuItemButtonLabel'
]

{ #category : #rendering }
LuiMenuItem >> anchorClicked: aString [
	Transcript show: 'Clicked ' , aString; cr 
]

{ #category : #building }
LuiMenuItem >> buildFrom: aMenuItemDefinition [
	self
		menuItemLabel: aMenuItemDefinition menuItemLabel;
		targetClass: aMenuItemDefinition targetClass;
		title: aMenuItemDefinition title.
	aMenuItemDefinition useAnchorButton
		ifTrue: [ self addAnchorButton: aMenuItemDefinition ]
		ifFalse: [ self addPushButton: aMenuItemDefinition ]
]

{ #category : #defaults }
LuiMenuItem >> defaultCssClasses [
	^ OrderedCollection with: 'mainMenuItem'
]

{ #category : #rendering }
LuiMenuItem >> mainPage [
	^ self parentComponentNamed: 'mainPage'
]

{ #category : #accessing }
LuiMenuItem >> menuItemLabel [
	^ menuItemLabel
]

{ #category : #accessing }
LuiMenuItem >> menuItemLabel: anObject [
	menuItemLabel := anObject
]

{ #category : #rendering }
LuiMenuItem >> renderComponentOn: html [
	html listItem
		addCommonProperties: self;
		with: [ self components do: [ :eachComponent | html render: eachComponent ] ]
]

{ #category : #accessing }
LuiMenuItem >> targetClass [
	^ targetClass
]

{ #category : #accessing }
LuiMenuItem >> targetClass: anObject [
	targetClass := anObject
]

{ #category : #'as yet unclassified' }
LuiMenuItem >> useAnchorButton [
	self components detect: [ :each | each class = LuiAnchor ] ifNone: [ ^ false ].
	^ true
]
