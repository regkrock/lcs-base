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
LuiAltTextAttribute >> altText [
	^ self cachedValue
]

{ #category : 'accessing' }
LuiAltTextAttribute >> altText: aString [
	self valueBlock: [ aString ]
]
