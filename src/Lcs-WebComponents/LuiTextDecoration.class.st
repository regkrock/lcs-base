Class {
	#name : 'LuiTextDecoration',
	#superclass : 'LuiComponentDecoration',
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
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
