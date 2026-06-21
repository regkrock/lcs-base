Class {
	#name : 'LuiCallbackAttribute',
	#superclass : 'LuiComponentAttribute',
	#category : 'Lcs-WebComponents-Attributes',
	#package : 'Lcs-WebComponents',
	#tag : 'Attributes'
}

{ #category : 'constants' }
LuiCallbackAttribute class >> attributeName [
	^ 'callback'
]

{ #category : 'accessing' }
LuiCallbackAttribute >> callback [
	^ self cachedValue
]

{ #category : 'accessing' }
LuiCallbackAttribute >> callback: aBlock [
	self valueBlock: [ aBlock ]
]

{ #category : 'accessing' }
LuiCallbackAttribute >> callbackBlock: aBlock [
	self valueBlock: aBlock
]
