Class {
	#name : 'LuiAnchor',
	#superclass : 'LuiComponent',
	#category : 'Lcs-WebComponents-Buttons',
	#package : 'Lcs-WebComponents',
	#tag : 'Buttons'
}

{ #category : 'as yet unclassified' }
LuiAnchor class >> newSeasLogo [
	^ (self named: 'logo')
		cssClass: 'logo';
		beBlankTarget;
		url: 'https://www.sailseas.com/Monmouth/';
		addImageComponent: LuiImage seasMonmouthFavicon;
		yourself
]

{ #category : 'components' }
LuiAnchor >> addImageComponent [
	^ self addImageComponent: (LuiImage named: 'image')
]

{ #category : 'components' }
LuiAnchor >> addImageComponent: anImageComponent [
	self hasImageComponent
		ifTrue: [ LcsError signal: 'Image component already exists' ].
	^ self addComponent: (anImageComponent componentName: 'image')
]

{ #category : 'components' }
LuiAnchor >> addSpanComponent [
	^ self addComponent: (LuiSpan named: 'span')
]

{ #category : 'attributes' }
LuiAnchor >> anchorClicked [
	Transcript show: 'Clicked ' , self label; cr 
]

{ #category : 'attributes - commands' }
LuiAnchor >> beBlankTarget [
	self attributes targetAttribute beBlankTarget
]

{ #category : 'initialize' }
LuiAnchor >> componentAttributesClass [
	^ LuiAnchorAttributes
]

{ #category : 'testing' }
LuiAnchor >> hasImageComponent [
	^ (self componentNamed: 'image') notNil
]

{ #category : 'testing' }
LuiAnchor >> hasNoImageComponent [
	(self componentNamed: 'image') isNil
]

{ #category : 'testing' }
LuiAnchor >> hasNoSpanComponent [
	(self componentNamed: 'span') isNil
]

{ #category : 'testing' }
LuiAnchor >> hasNoTextDecoration [
	^ self componentDecorations hasNoTextDecoration
]

{ #category : 'testing' }
LuiAnchor >> hasSpanComponent [
	^ (self componentNamed: 'span') notNil
]

{ #category : 'testing' }
LuiAnchor >> hasTextDecoration [
	^ self componentDecorations hasTextDecoration
]

{ #category : 'components' }
LuiAnchor >> imageComponent [
	self hasImageComponent ifFalse: [ self addImageComponent ].
	^ self componentNamed: 'image'
]

{ #category : 'attributes' }
LuiAnchor >> labelBlock: aBlock [
	self attributes labelBlock: aBlock
]

{ #category : 'rendering' }
LuiAnchor >> renderComponentOn: html [
	html anchor
		addCommonAttributes: self;
		"callback: [ self showLabelOnTranscript ];"
		with: [ self renderDetailsOn: html ] 
]

{ #category : 'rendering' }
LuiAnchor >> renderDetailsOn: html [
	self hasTextDecoration ifTrue: [
		html text: self text .
		^ self ].
 	super renderDetailsOn: html 
]

{ #category : 'components' }
LuiAnchor >> spanComponent [
	self hasSpanComponent ifFalse: [ self addSpanComponent ].
	^ self componentNamed: 'span'
]

{ #category : 'attributes' }
LuiAnchor >> target: aString [
	self attributes target: aString
]

{ #category : 'decorations' }
LuiAnchor >> textDecoration [
	^ self componentDecorations textDecoration
]

{ #category : 'attributes' }
LuiAnchor >> url [
	^ self attributes url
]

{ #category : 'attributes' }
LuiAnchor >> url: aString [
	self attributes url: aString
]

{ #category : 'attributes' }
LuiAnchor >> valueBlock: aBlock [
	self labelComponent valueBlock: aBlock
]
