Class {
	#name : 'LuiAltTextProperty',
	#superclass : 'LuiComponentProperty',
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'constants' }
LuiAltTextProperty class >> propertyName [
	^ 'altText'
]

{ #category : 'accessing' }
LuiAltTextProperty >> text [
	^ self cachedValue
]

{ #category : 'accessing' }
LuiAltTextProperty >> text: aString [
	self valueBlock: [ aString ]
]

{ #category : 'accessing' }
LuiAltTextProperty >> textBlock: aBlock [
	self valueBlock: aBlock
]
