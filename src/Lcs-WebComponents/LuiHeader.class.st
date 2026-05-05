Class {
	#name : 'LuiHeader',
	#superclass : 'LuiComponent',
	#instVars : [
		'level'
	],
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'as yet unclassified' }
LuiHeader >> defaultCssClasses [
	^ OrderedCollection with: 'header'
]

{ #category : 'rendering' }
LuiHeader >> renderComponentOn: html [
	html header 
		addCommonProperties: self;
		with: [
			self renderSubcomponentsOn: html]
]
