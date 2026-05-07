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
	^ self selectorNameFrom: self label
]

{ #category : 'as yet unclassified' }
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
	url := aString
]
