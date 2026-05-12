Class {
	#name : 'LuiAnchor',
	#superclass : 'LuiButton',
	#instVars : [
		'text'
	],
	#category : 'Lcs-WebComponents-Buttons',
	#package : 'Lcs-WebComponents',
	#tag : 'Buttons'
}

{ #category : 'properties' }
LuiAnchor >> anchorClicked [
	Transcript show: 'Clicked ' , self label; cr 
]

{ #category : 'testing' }
LuiAnchor >> hasNoTextComponent [
	(self componentNamed: 'text') isNil
]

{ #category : 'testing' }
LuiAnchor >> hasTextComponent [
	self textComponent notNil
]

{ #category : 'properties' }
LuiAnchor >> labelBlock: aBlock [
	self attributes labelBlock: aBlock
]

{ #category : 'rendering' }
LuiAnchor >> renderComponentOn: html [
	html anchor
		addCommonAttributes: self;
		callback: [ self showLabelOnTranscript. ];
		with: [ self renderDetailsOn: html ] 
]

{ #category : 'rendering' }
LuiAnchor >> renderDetailsOn: html [
	self hasTextComponent ifTrue: [ ^ super renderDetailsOn: html ].
	html text: self text
]

{ #category : 'accessing' }
LuiAnchor >> text [
	^ self textComponent 
		ifNil: [ self text ] 
		ifNotNil: [ self textComponent text ]
]

{ #category : 'accessing' }
LuiAnchor >> text: anObject [
	text := anObject
]

{ #category : 'testing' }
LuiAnchor >> textComponent [
	^ self componentNamed: 'text'
]

{ #category : 'rendering' }
LuiAnchor >> url: aString [
	self attributes url: aString
]

{ #category : 'properties' }
LuiAnchor >> valueBlock: aBlock [
	self labelComponent valueBlock: aBlock
]
