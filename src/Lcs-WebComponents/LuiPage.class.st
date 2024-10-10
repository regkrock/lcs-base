Class {
	#name : #LuiPage,
	#superclass : #LuiComponent,
	#category : #'Lcs-WebComponents-Base'
}

{ #category : #rendering }
LuiPage >> renderComponentOn: html [
	html div
		addCommonProperties: self;
		with: [self renderSubcomponentsOn: html]
]
