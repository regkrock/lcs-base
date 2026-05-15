Class {
	#name : 'LuiMenuItem',
	#superclass : 'LuiMenuObject',
	#instVars : [
		'targetClass',
		'label'
	],
	#category : 'Lcs-WebComponents-Menus',
	#package : 'Lcs-WebComponents',
	#tag : 'Menus'
}

{ #category : 'components - adding' }
LuiMenuItem >> addImageComponent [
	^ self addFirstComponent: (LuiImage named: 'image')
]

{ #category : 'components - adding' }
LuiMenuItem >> addSpanComponent [
	^ self addComponent: (LuiSpan named: 'span')
]

{ #category : 'rendering' }
LuiMenuItem >> anchorClicked: aString [
	Transcript show: 'Clicked ' , aString; cr 
]

{ #category : 'building' }
LuiMenuItem >> buildFrom: aMenuItemDefinition [
	self
		label: aMenuItemDefinition label;
		targetClass: aMenuItemDefinition targetClass;
		title: aMenuItemDefinition title
]

{ #category : 'defaults' }
LuiMenuItem >> defaultCssClasses [
	^ OrderedCollection with: 'mainMenuItem'
]

{ #category : 'testing' }
LuiMenuItem >> hasImageComponent [
	^ (self componentNamed: 'image') notNil
]

{ #category : 'testing' }
LuiMenuItem >> hasSpanComponent [
	^ ( self componentNamed: 'span') notNil
]

{ #category : 'components' }
LuiMenuItem >> imageComponent [
	self hasImageComponent ifFalse: [ self addImageComponent ].
	^ self componentNamed: 'image'
]

{ #category : 'attributes' }
LuiMenuItem >> label [
	^ self spanComponent text
]

{ #category : 'attributes' }
LuiMenuItem >> label: aString [
	self spanComponent text: aString
]

{ #category : 'rendering' }
LuiMenuItem >> renderComponentOn: html [
	html listItem
		addCommonAttributes: self;
		with: [ self renderDetailsOn: html ]
]

{ #category : 'components' }
LuiMenuItem >> spanComponent [
	self hasSpanComponent ifFalse: [ self addSpanComponent ].
	^ self componentNamed: 'span'
]

{ #category : 'accessing' }
LuiMenuItem >> targetClass [
	^ targetClass
]

{ #category : 'accessing' }
LuiMenuItem >> targetClass: anObject [
	targetClass := anObject
]
