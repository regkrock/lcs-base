Class {
	#name : 'LuiPage',
	#superclass : 'LuiComponent',
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'rendering' }
LuiPage >> renderComponentOn: html [
	html div
		addCommonProperties: self;
		with: [self renderSubcomponentsOn: html]
]
