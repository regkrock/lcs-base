Class {
	#name : 'LuiOnClickAttribute',
	#superclass : 'LuiJavascriptAttribute',
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
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
