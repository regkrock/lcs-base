Class {
	#name : 'LuiMenuItem',
	#superclass : 'LuiMenuObject',
	#instVars : [
		'targetClass',
		'label'
	],
	#category : 'Lcs-WebComponents-Menus',
	#package : 'Lcs-WebComponents',
	#tag : 'Menus'
}

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
		label: aMenuItemDefinition label;
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
LuiMenuItem >> isPushButton [
	self components detect: [ :each | each class = LuiPushButton ] ifNone: [ ^ false ].
	^ true
]

{ #category : 'accessing' }
LuiMenuItem >> label [
	^ label
]

{ #category : 'accessing' }
LuiMenuItem >> label: anObject [
	label := anObject
]

{ #category : 'rendering' }
LuiMenuItem >> mainPage [
	^ self parentComponentNamed: 'mainPage'
]

{ #category : 'building' }
LuiMenuItem >> pushButtonFor: aMenuItemDefinition [
	| button |
	button := LuiPushButton named: 'button' on: self.
	button replaceExistingCssClassesWithCssClass: (aMenuItemDefinition buttonCssClasses ifEmpty: [ 'menuItemButton' ]).
	button label: aMenuItemDefinition label.
	^ button
]

{ #category : 'rendering' }
LuiMenuItem >> renderComponentOn: html [
	html listItem
		addCommonAttributes: self;
		with: [ self renderDetailsOn: html ]
]

{ #category : 'accessing' }
LuiMenuItem >> targetClass [
	^ targetClass
]

{ #category : 'accessing' }
LuiMenuItem >> targetClass: anObject [
	targetClass := anObject
]
