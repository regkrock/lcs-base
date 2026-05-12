Class {
	#name : 'LuiNameAttribute',
	#superclass : 'LuiComponentAttribute',
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'constants' }
LuiNameAttribute class >> attributeName [
	^ 'name'
]

{ #category : 'accessing' }
LuiNameAttribute >> name: aString [
	self valueBlock: [ aString ]
]
