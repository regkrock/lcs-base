Class {
	#name : 'LuiMultipleSelect',
	#superclass : 'LuiSelect',
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'rendering' }
LuiMultipleSelect >> renderComponentOn: html [
	html multiSelect
		addCommonAttributes: self;
		with: [ self renderDetailsOn: html ]
]
