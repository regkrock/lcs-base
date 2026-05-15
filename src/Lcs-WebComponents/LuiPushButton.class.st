Class {
	#name : 'LuiPushButton',
	#superclass : 'LuiButton',
	#category : 'Lcs-WebComponents-Buttons',
	#package : 'Lcs-WebComponents',
	#tag : 'Buttons'
}

{ #category : 'components - adding' }
LuiPushButton >> addLeadingImageComponent [
	self addFirstComponent: (LuiImage named: 'leadingImage')
]

{ #category : 'components - adding' }
LuiPushButton >> addTrailingImageComponent [
	self addComponent: (LuiImage named: 'trailingImage')
]

{ #category : 'initialize' }
LuiPushButton >> beButtonType [
	self buttonTypeAttribute beButtonType
]

{ #category : 'initialize' }
LuiPushButton >> beSubmitType [
	self buttonTypeAttribute beSubmitType
]

{ #category : 'initialize' }
LuiPushButton >> buttonTypeAttribute [
	^ self attributes buttonTypeAttribute
]

{ #category : 'testing' }
LuiPushButton >> hasLeadingImageComponent [
	^ (self componentNamed: 'leadingImage') notNil
]

{ #category : 'testing' }
LuiPushButton >> hasTrailingImageComponent [
	^ (self componentNamed: 'trailingImage') notNil
]

{ #category : 'initialize' }
LuiPushButton >> initialize [
	super initialize.
	self beButtonType
]

{ #category : 'components' }
LuiPushButton >> leadingImageComponent [
	self hasLeadingImageComponent ifFalse: [ self addLeadingImageComponent ].
	^ self componentNamed: 'leadingImage'
]

{ #category : 'components' }
LuiPushButton >> leadingImageUrl: aPath [
	self leadingImageComponent
		url: aPath
]

{ #category : 'components' }
LuiPushButton >> leadingImageUrl: aPath altText: aString [
	self leadingImageComponent
		url: aPath;
		altText: aString
]

{ #category : 'rendering' }
LuiPushButton >> renderComponentOn: html [
	html button
		addCommonAttributes: self;
		"onClick: (html jQuery ajax callback: [:v | self halt]);"
		with: [ self renderDetailsOn: html ]
]

{ #category : 'components' }
LuiPushButton >> trailingImageComponent [
	self hasTrailingImageComponent ifFalse: [ self addTrailingImageComponent ].
	^ self componentNamed: 'trailingImage'
]

{ #category : 'components' }
LuiPushButton >> trailingImageUrl: aPath [
	self trailingImageComponent
		url: aPath
]

{ #category : 'components' }
LuiPushButton >> trailingImageUrl: aPath altText: aString [
	self trailingImageComponent
		url: aPath;
		altText: aString
]
