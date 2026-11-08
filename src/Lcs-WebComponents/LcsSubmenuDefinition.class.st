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

{ #category : 'conversion' }
LcsSubmenuDefinition >> asMenuComponent [
	| menu |
	menu := LuiDropDownMenuItem named: self componentName label: self label.
	self parent isNavigationMenuDefinition 
		ifTrue: [ menu cssClass: LuiCssClassesMap / #'nav-item']
		ifFalse: [ menu cssClass: LuiCssClassesMap / #'submenu-item'].
	self menuComponentDefintions do: [ :each |
		menu submenuComponent addComponent: each asMenuComponent ].
	^ menu
]

{ #category : 'constant' }
LcsSubmenuDefinition >> componentClass [
	^ LuiMenu
]

{ #category : 'asking' }
LcsSubmenuDefinition >> componentName [
	^ self _componentName
		ifNil: [ (self selectorNameFrom: self label) , 'MenuItem' ]
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
