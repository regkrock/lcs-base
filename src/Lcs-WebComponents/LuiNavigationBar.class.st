Class {
	#name : 'LuiNavigationBar',
	#superclass : 'LuiComponent',
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'rendering' }
LuiNavigationBar >> renderComponentOn: html [
	html navigation 
		addCommonProperties: self;
		with: [
			self renderSubcomponentsOn: html ]
]
