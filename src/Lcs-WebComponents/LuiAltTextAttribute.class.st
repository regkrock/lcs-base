Class {
	#name : 'LuiAltTextAttribute',
	#superclass : 'LuiComponentAttribute',
	#category : 'Lcs-WebComponents-Attributes',
	#package : 'Lcs-WebComponents',
	#tag : 'Attributes'
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
