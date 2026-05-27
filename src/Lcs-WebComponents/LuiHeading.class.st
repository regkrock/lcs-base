Class {
	#name : 'LuiHeading',
	#superclass : 'LuiComponent',
	#instVars : [
		'level'
	],
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'defaults' }
LuiHeading >> defaultCssClasses [
	^ OrderedCollection with: ''
]

{ #category : 'initialize' }
LuiHeading >> initialize [
	super initialize.
	"self headingLevel: 1."
]

{ #category : 'rendering' }
LuiHeading >> renderComponentOn: html [
	html heading
		addCommonAttributes: self;
		with: [ self renderDetailsOn: html ]
]

{ #category : 'rendering' }
LuiHeading >> renderDetailsOn: html [
	html text: self text
]
