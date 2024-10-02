Class {
	#name : #LcsSubmenuDefinition,
	#superclass : #LcsMenuDefinition,
	#instVars : [
		'menuComponentDefintions',
		'menuItemLabel'
	],
	#category : #'Lcs-WebComponents-Menus'
}

{ #category : #building }
LcsSubmenuDefinition >> addMenuComponentDefintion: aMenuComponentDefintion [
	aMenuComponentDefintion parent: self.
	self menuComponentDefintions add: aMenuComponentDefintion
]

{ #category : #constant }
LcsSubmenuDefinition >> componentClass [
	^ LuiSubmenu
]

{ #category : #asking }
LcsSubmenuDefinition >> componentName [
	^ self selectorNameFrom: self menuItemLabel
]

{ #category : #initialize }
LcsSubmenuDefinition >> initialize [
	super initialize.
	self menuComponentDefintions: OrderedCollection new
]

{ #category : #accessing }
LcsSubmenuDefinition >> menuComponentDefintions [
	^ menuComponentDefintions
]

{ #category : #initialize }
LcsSubmenuDefinition >> menuComponentDefintions: anObject [ 
	menuComponentDefintions := anObject
]

{ #category : #accessing }
LcsSubmenuDefinition >> menuItemLabel [
	^ menuItemLabel
]

{ #category : #accessing }
LcsSubmenuDefinition >> menuItemLabel: anObject [
	menuItemLabel := anObject
]
