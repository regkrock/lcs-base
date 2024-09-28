Class {
	#name : #LcsMenuItemDefinition,
	#superclass : #LcsMenuDefinition,
	#instVars : [
		'menuName',
		'submenu'
	],
	#category : #'Lcs-WebComponents-Menus'
}

{ #category : #asking }
LcsMenuItemDefinition >> componentName [
	^ self selectorNameFrom: self menuName
]

{ #category : #accessing }
LcsMenuItemDefinition >> menuName [
	^ menuName
]

{ #category : #accessing }
LcsMenuItemDefinition >> menuName: anObject [
	menuName := anObject
]

{ #category : #accessing }
LcsMenuItemDefinition >> submenu [
	^ submenu
]

{ #category : #accessing }
LcsMenuItemDefinition >> submenu: aSubmenu [
	aSubmenu parent: self.
	submenu := aSubmenu
]
