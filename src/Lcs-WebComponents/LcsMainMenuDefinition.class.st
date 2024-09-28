Class {
	#name : #LcsMainMenuDefinition,
	#superclass : #LcsMenuDefinition,
	#instVars : [
		'menuGroups',
		'menuName'
	],
	#category : #'Lcs-WebComponents-Menus'
}

{ #category : #'menu groups' }
LcsMainMenuDefinition >> addGroup: aMenuGroup [
	aMenuGroup parent: self.
	self menuGroups add: aMenuGroup
]

{ #category : #asking }
LcsMainMenuDefinition >> componentName [
	^ self menuName
]

{ #category : #initialize }
LcsMainMenuDefinition >> initialize [
	super initialize.
	self menuGroups: OrderedCollection new
]

{ #category : #accessing }
LcsMainMenuDefinition >> menuGroups [
	^ menuGroups
]

{ #category : #accessing }
LcsMainMenuDefinition >> menuGroups: anObject [
	menuGroups := anObject
]

{ #category : #accessing }
LcsMainMenuDefinition >> menuName [
	^ menuName
]

{ #category : #accessing }
LcsMainMenuDefinition >> menuName: anObject [
	menuName := anObject
]
