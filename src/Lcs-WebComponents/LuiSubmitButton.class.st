Class {
	#name : 'LuiSubmitButton',
	#superclass : 'LuiButton',
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'initialize' }
LuiSubmitButton >> initialize [
	super initialize.
	self beSubmitType
]

{ #category : 'rendering' }
LuiSubmitButton >> renderComponentOn: html [
	html button
		addCommonAttributes: self;
		with: [ self renderDetailsOn: html ]
]
