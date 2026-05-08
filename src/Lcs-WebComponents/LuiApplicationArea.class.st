Class {
	#name : 'LuiApplicationArea',
	#superclass : 'LuiComponent',
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'defaults' }
LuiApplicationArea >> defaultCssClasses [
	^ OrderedCollection with: 'applicationArea'
]

{ #category : 'rendering' }
LuiApplicationArea >> renderDetailsOn: html [
	html paragraph: self class name
]
