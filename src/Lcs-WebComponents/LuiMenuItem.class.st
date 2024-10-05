Class {
	#name : #LuiMenuItem,
	#superclass : #LuiMenuObject,
	#instVars : [
		'menuItemLabel',
		'targetClass'
	],
	#category : #'Lcs-WebComponents-Menus'
}

{ #category : #rendering }
LuiMenuItem >> anchorClicked: aString [
	Transcript show: 'Clicked ' , aString; cr 
]

{ #category : #building }
LuiMenuItem >> buildFrom: aMenuItemDefinition [
	self 
		menuItemLabel: aMenuItemDefinition menuItemLabel;
		targetClass: aMenuItemDefinition targetClass
]

{ #category : #'as yet unclassified' }
LuiMenuItem >> defaultCssClasses [
	^ OrderedCollection with: 'mainMenuItem'
]

{ #category : #'as yet unclassified' }
LuiMenuItem >> initialize [
	super initialize
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
	super renderComponentOn: html.
	html listItem
		id: self componentId;
		class: self cssClassesString;
		dataName: self componentName;
		dataStClass: self;
		with: [ html anchor
				class: (self parentComponent class = LuiMainMenu
						ifTrue: [ 'mainMenuItemButton' ]
						ifFalse: [ 'submenuItemButton' ]);
				callback: [ self anchorClicked: self menuItemLabel asString.
					self mainPage nextApplicationAreaClass: self targetClass ];
				with: self menuItemLabel asString ]
]

{ #category : #accessing }
LuiMenuItem >> targetClass [
	^ targetClass
]

{ #category : #accessing }
LuiMenuItem >> targetClass: anObject [
	targetClass := anObject
]
