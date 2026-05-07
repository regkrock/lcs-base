Class {
	#name : 'LcsSubmenuDefinition',
	#superclass : 'LcsMenuDefinition',
	#instVars : [
		'menuComponentDefintions',
		'label'
	],
	#category : 'Lcs-WebComponents-Menus',
	#package : 'Lcs-WebComponents',
	#tag : 'Menus'
}

{ #category : 'building' }
LcsSubmenuDefinition >> addDefinition: aMenuComponentDefintion [
	aMenuComponentDefintion parent: self.
	self menuComponentDefintions add: aMenuComponentDefintion
]

{ #category : 'constant' }
LcsSubmenuDefinition >> componentClass [
	^ LuiSubmenu
]

{ #category : 'asking' }
LcsSubmenuDefinition >> componentName [
	^ self selectorNameFrom: self label
]

{ #category : 'initialize' }
LcsSubmenuDefinition >> initialize [
	super initialize.
	self menuComponentDefintions: OrderedCollection new
]

{ #category : 'accessing' }
LcsSubmenuDefinition >> label [
	^ label
]

{ #category : 'accessing' }
LcsSubmenuDefinition >> label: anObject [
	label := anObject
]

{ #category : 'accessing' }
LcsSubmenuDefinition >> menuComponentDefintions [
	^ menuComponentDefintions
]

{ #category : 'accessing' }
LcsSubmenuDefinition >> menuComponentDefintions: anObject [ 
	menuComponentDefintions := anObject
]
