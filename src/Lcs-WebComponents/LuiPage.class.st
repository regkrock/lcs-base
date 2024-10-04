Class {
	#name : #LuiPage,
	#superclass : #LuiComponent,
	#category : #'Lcs-WebComponents-Base'
}

{ #category : #rendering }
LuiPage >> renderComponentOn: html [
	self isTraceOn ifTrue: [ self renderTraceOn: html ].
	html div
		id: self componentId asString;
		class: self cssClassesString;
		dataName: self componentName;
		dataStClass: self;
		with: [self renderSubcomponentsOn: html]
]
