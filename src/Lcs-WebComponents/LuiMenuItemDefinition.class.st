Class {
	#name : 'LuiMenuItemDefinition',
	#superclass : 'LcsMenuDefinition',
	#instVars : [
		'targetClass',
		'url',
		'buttonType',
		'title',
		'buttonCssClasses',
		'onClickAction',
		'label'
	],
	#category : 'Lcs-WebComponents-Menus',
	#package : 'Lcs-WebComponents',
	#tag : 'Menus'
}

{ #category : 'conversion' }
LuiMenuItemDefinition >> asMenuComponent [
	| menu |
	menu := LuiMenuItem named: self componentName.
	self isAnchor ifTrue: [
		menu anchorLabel: self label.
		menu anchorHref: self url].
	^ menu
]

{ #category : 'configuration' }
LuiMenuItemDefinition >> beAnchor [
	self buttonType: 'anchor'
]

{ #category : 'configuration' }
LuiMenuItemDefinition >> bePushButton [
	self buttonType: 'push'
]

{ #category : 'accessing' }
LuiMenuItemDefinition >> buttonCssClasses [
	^ buttonCssClasses 
]

{ #category : 'accessing' }
LuiMenuItemDefinition >> buttonCssClasses: aString [
	buttonCssClasses  := aString
]

{ #category : 'accessing' }
LuiMenuItemDefinition >> buttonType [
	^ buttonType
]

{ #category : 'accessing' }
LuiMenuItemDefinition >> buttonType: anObject [
	buttonType := anObject
]

{ #category : 'constant' }
LuiMenuItemDefinition >> componentClass [
	^ LuiMenuItem
]

{ #category : 'asking' }
LuiMenuItemDefinition >> componentName [
	^ self _componentName
		ifNil: [ (self selectorNameFrom: self label) , 'MenuItem']
]

{ #category : 'initialize' }
LuiMenuItemDefinition >> initialize [
	super initialize.
	self buttonCssClasses: ''.
	self bePushButton
]

{ #category : 'testing' }
LuiMenuItemDefinition >> isAnchor [
	^ self buttonType = 'anchor'
]

{ #category : 'testing' }
LuiMenuItemDefinition >> isPushButton [
	^ self buttonType = 'push'
]

{ #category : 'accessing' }
LuiMenuItemDefinition >> label [
	^ label
]

{ #category : 'accessing' }
LuiMenuItemDefinition >> label: anObject [
	label := anObject
]

{ #category : 'accessing' }
LuiMenuItemDefinition >> onClickAction [
	^ onClickAction
]

{ #category : 'accessing' }
LuiMenuItemDefinition >> onClickAction: anObject [
	onClickAction := anObject
]

{ #category : 'accessing' }
LuiMenuItemDefinition >> targetClass [
	^ targetClass
]

{ #category : 'accessing' }
LuiMenuItemDefinition >> targetClass: anObject [
	targetClass := anObject
]

{ #category : 'accessing' }
LuiMenuItemDefinition >> title [
	^ title
]

{ #category : 'accessing' }
LuiMenuItemDefinition >> title: anObject [
	title := anObject
]

{ #category : 'accessing' }
LuiMenuItemDefinition >> url [
	^ url
]

{ #category : 'accessing' }
LuiMenuItemDefinition >> url: aString [
	self beAnchor.
	url := aString
]
