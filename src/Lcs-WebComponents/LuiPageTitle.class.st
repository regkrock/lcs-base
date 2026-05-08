Class {
	#name : 'LuiPageTitle',
	#superclass : 'LuiComponent',
	#instVars : [
		'level'
	],
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'defaults' }
LuiPageTitle >> defaultCssClasses [
	^ OrderedCollection with: 'pageTitle'
]

{ #category : 'rendering' }
LuiPageTitle >> renderDetailsOn: html [
	html text: self domainObject asString
]

{ #category : 'updating' }
LuiPageTitle >> text: aString [
	self domainObject: aString
]
