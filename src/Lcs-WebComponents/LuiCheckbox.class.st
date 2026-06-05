Class {
	#name : 'LuiCheckbox',
	#superclass : 'LuiFormInputComponent',
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'initialize' }
LuiCheckbox >> initialize [
	super initialize.
]

{ #category : 'rendering' }
LuiCheckbox >> renderComponentOn: html [
	html checkbox
		addCommonAttributes: self;
		text: self text
]
