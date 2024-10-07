Class {
	#name : #LuiPage,
	#superclass : #LuiComponent,
	#category : #'Lcs-WebComponents-Base'
}

{ #category : #rendering }
LuiPage >> renderComponentOn: html [
	self isTraceOn ifTrue: [ self renderTraceOn: html ].
	html div
		addCommonProperties: self;
		with: [self renderSubcomponentsOn: html]
]
