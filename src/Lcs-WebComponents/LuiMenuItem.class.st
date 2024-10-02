Class {
	#name : #LuiMenuItem,
	#superclass : #LuiMenuObject,
	#instVars : [
		'menuItemLabel'
	],
	#category : #'Lcs-WebComponents-Menus'
}

{ #category : #rendering }
LuiMenuItem >> anchorClicked: aString [
	Transcript show: 'Clicked ' , aString; cr 
]

{ #category : #building }
LuiMenuItem >> buildFrom: aMenuItemDefinition [
	self menuItemLabel: aMenuItemDefinition menuItemLabel
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
		"class: self cssClassesString;"
		class: 'mainMenuItem';
		"class: ((self parentComponent class = LuiMainMenu) ifTrue: ['mainMenuItem'] ifFalse: ['subMenuItem']);"
		dataName: self componentName;
		dataStClass: self;
		with: [
			html anchor
				class: ((self parentComponent class = LuiMainMenu) ifTrue: ['mainMenuItemButton'] ifFalse: ['submenuItemButton']) ;
				callback: [ self anchorClicked: self menuItemLabel asString];
				with: self menuItemLabel asString ]
]
