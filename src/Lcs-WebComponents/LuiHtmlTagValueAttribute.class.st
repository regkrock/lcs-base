Class {
	#name : 'LuiHtmlTagValueAttribute',
	#superclass : 'LuiComponentAttribute',
	#category : 'Lcs-WebComponents-Attributes',
	#package : 'Lcs-WebComponents',
	#tag : 'Attributes'
}

{ #category : 'constants' }
LuiHtmlTagValueAttribute class >> attributeName [
	^ 'htmlTagValue'
]

{ #category : 'accessing' }
LuiHtmlTagValueAttribute >> htmlTagValue [
	^ self cachedValue
]

{ #category : 'accessing' }
LuiHtmlTagValueAttribute >> htmlTagValue: aString [
	self valueBlock: [ aString ]
]

{ #category : 'initialize' }
LuiHtmlTagValueAttribute >> initialize [
	super initialize.
	self tagAttributeSetterSelector: #value:
]
