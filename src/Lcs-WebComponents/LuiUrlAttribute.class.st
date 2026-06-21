Class {
	#name : 'LuiUrlAttribute',
	#superclass : 'LuiComponentAttribute',
	#category : 'Lcs-WebComponents-Attributes',
	#package : 'Lcs-WebComponents',
	#tag : 'Attributes'
}

{ #category : 'constant' }
LuiUrlAttribute class >> attributeName [
	^ 'url'
]

{ #category : 'initialize' }
LuiUrlAttribute >> initialize [
	super initialize.
	self valueBlock: [ nil ]
]

{ #category : 'property' }
LuiUrlAttribute >> url [
	^ self cachedValue
]

{ #category : 'property' }
LuiUrlAttribute >> url: aString [
	self valueBlock: [ aString ]
]

{ #category : 'property' }
LuiUrlAttribute >> urlBlock: aBlock [
	self valueBlock: aBlock
]

{ #category : 'property' }
LuiUrlAttribute >> value: aString [
	self valueBlock: [ aString ]
]
