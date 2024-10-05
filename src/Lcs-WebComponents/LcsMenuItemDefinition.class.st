Class {
	#name : #LcsMenuItemDefinition,
	#superclass : #LcsMenuDefinition,
	#instVars : [
		'menuItemLabel',
		'targetClass'
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

{ #category : #accessing }
LcsMenuItemDefinition >> targetClass [
	^ targetClass
]

{ #category : #accessing }
LcsMenuItemDefinition >> targetClass: anObject [
	targetClass := anObject
]
