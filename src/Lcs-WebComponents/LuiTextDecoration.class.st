Class {
	#name : 'LuiTextDecoration',
	#superclass : 'LuiComponentDecoration',
	#category : 'Lcs-WebComponents-Decorations',
	#package : 'Lcs-WebComponents',
	#tag : 'Decorations'
}

{ #category : 'constants' }
LuiTextDecoration class >> decorationName [
	^ 'text'
]

{ #category : 'decoration' }
LuiTextDecoration >> text [
	^ self cachedValue
]

{ #category : 'decoration' }
LuiTextDecoration >> text: aString [
	self valueBlock: [ aString ]
]
