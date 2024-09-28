Class {
	#name : #LuiExampleMainPage,
	#superclass : #LuiPage,
	#category : #'Lcs-WebComponentsTests-Base'
}

{ #category : #rendering }
LuiExampleMainPage >> renderComponentOn: html [
	html div
		id: self componentId asString;
		class: self cssClassesString;
		with: [self renderSubcomponentsOn: html]
]
