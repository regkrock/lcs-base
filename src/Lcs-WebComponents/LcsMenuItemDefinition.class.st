Class {
	#name : #LcsMenuItemDefinition,
	#superclass : #LcsMenuDefinition,
	#instVars : [
		'menuItemLabel',
		'targetClass',
		'url',
		'buttonType',
		'title',
		'buttonCssClasses',
		'onClickAction'
	],
	#category : #'Lcs-WebComponents-Menus'
}

{ #category : #configuration }
LcsMenuItemDefinition >> beAnchor [
	self buttonType: 'anchor'
]

{ #category : #configuration }
LcsMenuItemDefinition >> bePushButton [
	self buttonType: 'button'
]

{ #category : #accessing }
LcsMenuItemDefinition >> buttonCssClasses [
	^ buttonCssClasses 
]

{ #category : #accessing }
LcsMenuItemDefinition >> buttonCssClasses: aString [
	buttonCssClasses  := aString
]

{ #category : #accessing }
LcsMenuItemDefinition >> buttonType [
	^ buttonType
]

{ #category : #accessing }
LcsMenuItemDefinition >> buttonType: anObject [
	buttonType := anObject
]

{ #category : #constant }
LcsMenuItemDefinition >> componentClass [
	^ LuiMenuItem
]

{ #category : #asking }
LcsMenuItemDefinition >> componentName [
	^ self selectorNameFrom: self menuItemLabel
]

{ #category : #'as yet unclassified' }
LcsMenuItemDefinition >> initialize [
	super initialize.
	self buttonCssClasses: ''
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
LcsMenuItemDefinition >> onClickAction [
	^ onClickAction
]

{ #category : #accessing }
LcsMenuItemDefinition >> onClickAction: anObject [
	onClickAction := anObject
]

{ #category : #accessing }
LcsMenuItemDefinition >> targetClass [
	^ targetClass
]

{ #category : #accessing }
LcsMenuItemDefinition >> targetClass: anObject [
	targetClass := anObject
]

{ #category : #accessing }
LcsMenuItemDefinition >> title [
	^ title
]

{ #category : #accessing }
LcsMenuItemDefinition >> title: anObject [
	title := anObject
]

{ #category : #accessing }
LcsMenuItemDefinition >> url [
	^ url
]

{ #category : #accessing }
LcsMenuItemDefinition >> url: aString [
	url := aString
]

{ #category : #testing }
LcsMenuItemDefinition >> useAnchorButton [
	^ self buttonType = 'anchor'
]

{ #category : #testing }
LcsMenuItemDefinition >> usePushButton [
	^ self buttonType = 'push'
]
