Class {
	#name : 'LuiPasswordInput',
	#superclass : 'LuiTextInput',
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'commands' }
LuiPasswordInput >> beCurrentPasswordAutocomplete [
	self autocomplete: 'current-' , self componentName
]

{ #category : 'commands' }
LuiPasswordInput >> beNewPasswordAutocomplete [
	self autocomplete: 'new-' , self componentName
]

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
