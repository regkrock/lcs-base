Class {
	#name : #LcsMenuItemDefinition,
	#superclass : #LcsMenuDefinition,
	#instVars : [
		'menuItemLabel'
	],
	#category : #'Lcs-WebComponents-Menus'
}

{ #category : #constant }
LcsMenuItemDefinition >> componentClass [
	^ LuiMenuItem
]

{ #category : #asking }
LcsMenuItemDefinition >> componentName [
	^ self selectorNameFrom: self menuItemLabel
]

{ #category : #accessing }
LcsMenuItemDefinition >> menuItemLabel [
	^ menuItemLabel
]

{ #category : #accessing }
LcsMenuItemDefinition >> menuItemLabel: anObject [
	menuItemLabel := anObject
]
