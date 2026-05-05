Class {
	#name : 'LuiNameProperty',
	#superclass : 'LuiComponentProperty',
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'constants' }
LuiNameProperty class >> propertyName [
	^ 'name'
]

{ #category : 'accessing' }
LuiNameProperty >> name: aString [
	self valueBlock: [ aString ]
]
