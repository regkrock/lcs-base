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

{ #category : 'components' }
LuiMenuItem >> _anchorComponent [
	^ self componentNamed: 'anchor'
]

{ #category : 'components' }
LuiMenuItem >> _buttonComponent [
	^ self componentNamed: 'button'
]

{ #category : 'components - adding' }
LuiMenuItem >> addAnchorComponent [
	^ self addComponent: (LuiAnchor named: 'anchor')
]

{ #category : 'components - adding' }
LuiMenuItem >> addButtonComponent [
	^ self addComponent: (LuiPushButton named: 'button')
]

{ #category : 'components' }
LuiMenuItem >> anchorComponent [
	self hasAnchorComponent ifFalse: [ self addAnchorComponent ].
	^ self _anchorComponent
]

{ #category : 'attributes' }
LuiMenuItem >> anchorCssClass: aString [
	self anchorComponent cssClass: aString
]

{ #category : 'button - attributes' }
LuiMenuItem >> anchorHref [
	self hasButtonComponent ifTrue: [ ^ nil ].
	^ self anchorComponent url
]

{ #category : 'button - attributes' }
LuiMenuItem >> anchorHref: aString [
	self ensureNoButtonComponent.
	self anchorComponent url: aString
]

{ #category : 'button - attributes' }
LuiMenuItem >> anchorLabel: aString [
	self ensureNoButtonComponent.
	self buttonComponent label: aString
]

{ #category : 'building' }
LuiMenuItem >> buildFrom: aMenuItemDefinition [
	self
		buttonLabel: aMenuItemDefinition label;
		targetClass: aMenuItemDefinition targetClass;
		title: aMenuItemDefinition title
]

{ #category : 'components' }
LuiMenuItem >> buttonComponent [
	self hasButtonComponent ifFalse: [ self addButtonComponent ].
	^ self _buttonComponent
]

{ #category : 'attributes' }
LuiMenuItem >> buttonCssClass: aString [
	self buttonComponent cssClass: aString
]

{ #category : 'button - attributes' }
LuiMenuItem >> buttonLabel: aString [
	self ensureNoAnchorComponent.
	self buttonComponent label: aString
]

{ #category : 'button - attributes' }
LuiMenuItem >> buttonOnClick [
	self hasAnchorComponent ifTrue: [ ^ nil ].
	^ self buttonComponent onClick
]

{ #category : 'button - attributes' }
LuiMenuItem >> buttonOnClick: aString [
	self ensureNoAnchorComponent.
	self buttonComponent onClick: aString
]

{ #category : 'components' }
LuiMenuItem >> buttonOrAnchorComponent [
	self hasButtonComponent ifTrue: [ ^ self buttonComponent ].
	self hasAnchorComponent ifTrue: [ ^ self anchorComponent ].
	^ nil
]

{ #category : 'attributes' }
LuiMenuItem >> callback [
	^ self buttonOrAnchorComponent callback
]

{ #category : 'attributes' }
LuiMenuItem >> callback: aBlock [
	self buttonOrAnchorComponent callback: aBlock
]

{ #category : 'defaults' }
LuiMenuItem >> defaultCssClasses [
	^ OrderedCollection with: 'menuItem'
]

{ #category : 'button - attributes' }
LuiMenuItem >> ensureNoAnchorComponent [
	self hasAnchorComponent
		ifTrue: [ LcsError
				signal: 'An anchor component already exists. A menu item can only have one or the other' ]
]

{ #category : 'button - attributes' }
LuiMenuItem >> ensureNoButtonComponent [
	self hasButtonComponent
		ifTrue: [ LcsError
				signal: 'An button component already exists. A menu item can only have one or the other' ]
]

{ #category : 'testing' }
LuiMenuItem >> hasAnchorComponent [
	^ ( self componentNamed: 'anchor') notNil
]

{ #category : 'testing' }
LuiMenuItem >> hasButtonComponent [
	^ ( self componentNamed: 'button') notNil
]

{ #category : 'testing' }
LuiMenuItem >> hasImageComponent [
	^ self buttonOrAnchorComponent hasImageComponent
]

{ #category : 'testing' }
LuiMenuItem >> hasSpanComponent [
	^ self buttonOrAnchorComponent hasSpanComponent
]

{ #category : 'button - attributes' }
LuiMenuItem >> href [
	^ self anchorHref
]

{ #category : 'button - attributes' }
LuiMenuItem >> href: aString [
	self anchorHref: aString
]

{ #category : 'components' }
LuiMenuItem >> imageComponent [
	self buttonOrAnchorComponent imageComponent
]

{ #category : 'attributes' }
LuiMenuItem >> imageCssClass: aString [
	self buttonOrAnchorComponent imageCssClass: aString
]

{ #category : 'attributes' }
LuiMenuItem >> imageUrl: aString [
	self buttonOrAnchorComponent imageUrl: aString
]

{ #category : 'attributes' }
LuiMenuItem >> label [
	^ self buttonOrAnchorComponent spanComponent text
]

{ #category : 'attributes' }
LuiMenuItem >> label: aString [
	self buttonOrAnchorComponent spanComponent text: aString
]

{ #category : 'button - attributes' }
LuiMenuItem >> onClick [
	^ self buttonOnClick
]

{ #category : 'button - attributes' }
LuiMenuItem >> onClick: aString [
	self buttonOnClick: aString
]

{ #category : 'rendering' }
LuiMenuItem >> renderComponentOn: html [
	html listItem
		addCommonAttributes: self;
		with: [ self renderDetailsOn: html ]
]

{ #category : 'components' }
LuiMenuItem >> spanComponent [
	^ self buttonOrAnchorComponent spanComponent
]

{ #category : 'attributes' }
LuiMenuItem >> spanCssClass: aString [
	self spanComponent cssClass: aString
]

{ #category : 'accessing' }
LuiMenuItem >> targetClass [
	^ targetClass
]

{ #category : 'accessing' }
LuiMenuItem >> targetClass: anObject [
	targetClass := anObject
]

{ #category : 'attributes' }
LuiMenuItem >> text [
	^ self buttonOrAnchorComponent text
]

{ #category : 'attributes' }
LuiMenuItem >> text: aString [
	self buttonOrAnchorComponent text: aString
]
