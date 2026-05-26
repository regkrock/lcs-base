Class {
	#name : 'LuiPushButton',
	#superclass : 'LuiComponent',
	#category : 'Lcs-WebComponents-Buttons',
	#package : 'Lcs-WebComponents',
	#tag : 'Buttons'
}

{ #category : 'components - adding' }
LuiPushButton >> addLeadingImageComponent [
	self addFirstComponent: (LuiImage named: 'leadingImage')
]

{ #category : 'components - adding' }
LuiPushButton >> addSpanComponent [
	self addComponent: (LuiSpan named: 'span')
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

{ #category : 'attributes' }
LuiPushButton >> buttonTypeAttribute [
	^ self attributes buttonTypeAttribute
]

{ #category : 'attributes' }
LuiPushButton >> callback [
	^ self attributes callback
]

{ #category : 'attributes' }
LuiPushButton >> callback: aBlock [
	self attributes callback: aBlock
]

{ #category : 'initialize' }
LuiPushButton >> componentAttributesClass [
	^ LuiPushButtonAttributes
]

{ #category : 'testing' }
LuiPushButton >> hasLeadingImageComponent [
	^ (self componentNamed: 'leadingImage') notNil
]

{ #category : 'testing' }
LuiPushButton >> hasSpanComponent [
	^ (self componentNamed: 'span') notNil
]

{ #category : 'testing' }
LuiPushButton >> hasTrailingImageComponent [
	^ (self componentNamed: 'trailingImage') notNil
]

{ #category : 'attributes' }
LuiPushButton >> imageCssClass: aString [
	self leadingImageComponent cssClass: aString
]

{ #category : 'attributes' }
LuiPushButton >> imageUrl [
	^ self leadingImageComponent url
]

{ #category : 'attributes' }
LuiPushButton >> imageUrl: aString [
	self leadingImageComponent url: aString
]

{ #category : 'initialize' }
LuiPushButton >> initialize [
	super initialize.
	self beButtonType
]

{ #category : 'decorations' }
LuiPushButton >> label [
	^ self spanComponent text
]

{ #category : 'decorations' }
LuiPushButton >> label: aString [
	self spanComponent text: aString
]

{ #category : 'components - updating' }
LuiPushButton >> leadingImageAltText: aString [
	self leadingImageComponent
		altText: aString
]

{ #category : 'components' }
LuiPushButton >> leadingImageComponent [
	self hasLeadingImageComponent ifFalse: [ self addLeadingImageComponent ].
	^ self componentNamed: 'leadingImage'
]

{ #category : 'components - updating' }
LuiPushButton >> leadingImageUrl: aPath [
	self leadingImageComponent
		url: aPath
]

{ #category : 'components - updating' }
LuiPushButton >> leadingImageUrl: aPath altText: aString [
	self leadingImageComponent
		url: aPath;
		altText: aString
]

{ #category : 'attributes' }
LuiPushButton >> onClick [
	^ self attributes onClick
]

{ #category : 'attributes' }
LuiPushButton >> onClick: aString [
	self attributes onClick: aString
]

{ #category : 'rendering' }
LuiPushButton >> renderComponentOn: html [
	html button
		addCommonAttributes: self;
		with: [ self renderDetailsOn: html ]
]

{ #category : 'rendering' }
LuiPushButton >> renderDetailsOn: html [
	self hasTextDecoration 
		ifTrue: [ html text: self text ]
		ifFalse: [ super renderDetailsOn: html ]
]

{ #category : 'components' }
LuiPushButton >> spanComponent [
	self hasSpanComponent ifFalse: [ self addSpanComponent ].
	^ self componentNamed: 'span'
]

{ #category : 'decorations' }
LuiPushButton >> text [
	^ self componentDecorations textDecoration text
]

{ #category : 'decorations' }
LuiPushButton >> text: aString [
	self componentDecorations textDecoration text: aString
]

{ #category : 'components' }
LuiPushButton >> trailingImageComponent [
	self hasTrailingImageComponent ifFalse: [ self addTrailingImageComponent ].
	^ self componentNamed: 'trailingImage'
]

{ #category : 'components - updating' }
LuiPushButton >> trailingImageUrl: aPath [
	self trailingImageComponent
		url: aPath
]

{ #category : 'components - updating' }
LuiPushButton >> trailingImageUrl: aPath altText: aString [
	self trailingImageComponent
		url: aPath;
		altText: aString
]
