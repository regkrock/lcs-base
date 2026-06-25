Class {
	#name : 'LuiButton',
	#superclass : 'LuiComponent',
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'components - adding' }
LuiButton >> addLeadingImageComponent [
	self addFirstComponent: (LuiImage named: 'leadingImage')
]

{ #category : 'components - adding' }
LuiButton >> addSpanComponent [
	self addComponent: (LuiSpan named: 'span')
]

{ #category : 'components - adding' }
LuiButton >> addTrailingImageComponent [
	self addComponent: (LuiImage named: 'trailingImage')
]

{ #category : 'initialize' }
LuiButton >> beButtonType [
	self buttonTypeAttribute beButtonType
]

{ #category : 'initialize' }
LuiButton >> beSubmitType [
	self buttonTypeAttribute beSubmitType
]

{ #category : 'attributes' }
LuiButton >> buttonTypeAttribute [
	^ self attributes buttonTypeAttribute
]

{ #category : 'attributes' }
LuiButton >> callback [
	^ self attributes callback
]

{ #category : 'attributes' }
LuiButton >> callback: aBlock [
	self attributes callback: aBlock
]

{ #category : 'initialize' }
LuiButton >> componentAttributesClass [
	^ LuiButtonAttributes
]

{ #category : 'defaults' }
LuiButton >> defaultCssClasses [
	^ OrderedCollection with: 'pushButton'
]

{ #category : 'testing' }
LuiButton >> hasLeadingImageComponent [
	^ (self componentNamed: 'leadingImage') notNil
]

{ #category : 'testing' }
LuiButton >> hasSpanComponent [
	^ (self componentNamed: 'span') notNil
]

{ #category : 'testing' }
LuiButton >> hasTrailingImageComponent [
	^ (self componentNamed: 'trailingImage') notNil
]

{ #category : 'attributes' }
LuiButton >> imageCssClass: aString [
	self leadingImageComponent cssClass: aString
]

{ #category : 'attributes' }
LuiButton >> imageUrl [
	^ self leadingImageComponent url
]

{ #category : 'attributes' }
LuiButton >> imageUrl: aString [
	self leadingImageComponent url: aString
]

{ #category : 'initialize' }
LuiButton >> initialize [
	super initialize.
	self beButtonType
]

{ #category : 'decorations' }
LuiButton >> label [
	^ self spanComponent text
]

{ #category : 'decorations' }
LuiButton >> label: aString [
	self spanComponent text: aString
]

{ #category : 'components - updating' }
LuiButton >> leadingImageAltText: aString [
	self leadingImageComponent
		altText: aString
]

{ #category : 'components' }
LuiButton >> leadingImageComponent [
	self hasLeadingImageComponent ifFalse: [ self addLeadingImageComponent ].
	^ self componentNamed: 'leadingImage'
]

{ #category : 'components - updating' }
LuiButton >> leadingImageUrl: aPath [
	self leadingImageComponent
		url: aPath
]

{ #category : 'components - updating' }
LuiButton >> leadingImageUrl: aPath altText: aString [
	self leadingImageComponent
		url: aPath;
		altText: aString
]

{ #category : 'attributes' }
LuiButton >> onClick [
	^ self attributes onClick
]

{ #category : 'attributes' }
LuiButton >> onClick: aString [
	self attributes onClick: aString
]

{ #category : 'rendering' }
LuiButton >> renderComponentOn: html [
	html button
		addCommonAttributes: self;
		with: [ self renderDetailsOn: html ]
]

{ #category : 'rendering' }
LuiButton >> renderDetailsOn: html [
	self hasTextDecoration 
		ifTrue: [ html text: self text ]
		ifFalse: [ super renderDetailsOn: html ]
]

{ #category : 'components' }
LuiButton >> spanComponent [
	self hasSpanComponent ifFalse: [ self addSpanComponent ].
	^ self componentNamed: 'span'
]

{ #category : 'decorations' }
LuiButton >> text [
	^ self componentDecorations textDecoration text
]

{ #category : 'decorations' }
LuiButton >> text: aString [
	self componentDecorations textDecoration text: aString
]

{ #category : 'components' }
LuiButton >> trailingImageComponent [
	self hasTrailingImageComponent ifFalse: [ self addTrailingImageComponent ].
	^ self componentNamed: 'trailingImage'
]

{ #category : 'components - updating' }
LuiButton >> trailingImageUrl: aPath [
	self trailingImageComponent
		url: aPath
]

{ #category : 'components - updating' }
LuiButton >> trailingImageUrl: aPath altText: aString [
	self trailingImageComponent
		url: aPath;
		altText: aString
]
