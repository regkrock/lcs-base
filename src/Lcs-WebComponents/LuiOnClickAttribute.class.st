Class {
	#name : 'LuiOnClickAttribute',
	#superclass : 'LuiJavascriptAttribute',
	#category : 'Lcs-WebComponents-Attributes',
	#package : 'Lcs-WebComponents',
	#tag : 'Attributes'
}

{ #category : 'defaults' }
LuiOnClickAttribute class >> attributeName [
	^ 'onClick'
]

{ #category : 'accessing' }
LuiOnClickAttribute >> onClick [
	^ self cachedValue
]

{ #category : 'accessing' }
LuiOnClickAttribute >> onClick: aString [
	self valueBlock: [ aString ]
]
