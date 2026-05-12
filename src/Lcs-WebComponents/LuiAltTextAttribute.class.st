Class {
	#name : 'LuiAltTextAttribute',
	#superclass : 'LuiComponentAttribute',
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'constants' }
LuiAltTextAttribute class >> attributeName [
	^ 'altText'
]

{ #category : 'accessing' }
LuiAltTextAttribute >> text [
	^ self cachedValue
]

{ #category : 'accessing' }
LuiAltTextAttribute >> text: aString [
	self valueBlock: [ aString ]
]

{ #category : 'accessing' }
LuiAltTextAttribute >> textBlock: aBlock [
	self valueBlock: aBlock
]
