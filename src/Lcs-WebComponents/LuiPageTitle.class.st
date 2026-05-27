Class {
	#name : 'LuiPageTitle',
	#superclass : 'LuiComponent',
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'defaults' }
LuiPageTitle >> defaultCssClasses [
	^ OrderedCollection with: 'pageTitle'
]

{ #category : 'rendering' }
LuiPageTitle >> renderDetailsOn: html [
	html text: self text
]
