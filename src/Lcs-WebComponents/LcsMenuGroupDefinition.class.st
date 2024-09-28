Class {
	#name : #LcsMenuGroupDefinition,
	#superclass : #LcsMenuDefinition,
	#instVars : [
		'menuName',
		'menuItems'
	],
	#category : #'Lcs-WebComponents-Menus'
}

{ #category : #'menu definitions' }
LcsMenuGroupDefinition >> addMenuItem: aMenuItem [
	aMenuItem parent: self.
	self menuItems add: aMenuItem
]

{ #category : #asking }
LcsMenuGroupDefinition >> componentName [
	^ self selectorNameFrom: self menuName
]

{ #category : #initialize }
LcsMenuGroupDefinition >> initialize [
	super initialize.
	self menuItems: OrderedCollection new
]

{ #category : #accessing }
LcsMenuGroupDefinition >> menuItems [
	^ menuItems
]

{ #category : #accessing }
LcsMenuGroupDefinition >> menuItems: anObject [
	menuItems := anObject
]

{ #category : #accessing }
LcsMenuGroupDefinition >> menuName [
	^ menuName
]

{ #category : #accessing }
LcsMenuGroupDefinition >> menuName: anObject [
	menuName := anObject
]
