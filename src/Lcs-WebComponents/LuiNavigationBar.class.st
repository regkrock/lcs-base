Class {
	#name : #LuiNavigationBar,
	#superclass : #LuiComponent,
	#category : #'Lcs-WebComponents-Base'
}

{ #category : #rendering }
LuiNavigationBar >> renderComponentOn: html [
	html navigation 
		addCommonProperties: self;
		with: [
			self renderSubcomponentsOn: html ]
]
