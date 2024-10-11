Class {
	#name : #LuiRoot,
	#superclass : #LuiComponent,
	#category : #'Lcs-WebComponents-Base'
}

{ #category : #constant }
LuiRoot class >> browserTabName [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
LuiRoot >> renderComponentOn: html [
	html div 
		addCommonProperties: self;
		with: [
			self renderSubcomponentsOn: html ]
]
