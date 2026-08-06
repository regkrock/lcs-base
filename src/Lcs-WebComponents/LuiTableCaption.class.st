Class {
	#name : 'LuiTableCaption',
	#superclass : 'LuiTableObjectComponent',
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'rendering' }
LuiTableCaption >> renderComponentOn: html [
	html caption
		addCommonAttributes: self;
		with: [ self valueAccessor read ]
]
