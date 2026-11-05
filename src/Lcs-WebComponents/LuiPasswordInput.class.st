Class {
	#name : 'LuiPasswordInput',
	#superclass : 'LuiTextInput',
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'gt views' }
LuiPasswordInput >> gtViewBaseTagName [
	^ super gtViewBaseTagName , ' type=''password'''
]

{ #category : 'rendering' }
LuiPasswordInput >> renderComponentOn: html [
	html passwordInput
		addCommonAttributes: self;
		value: self displayValue
]
