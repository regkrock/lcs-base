Class {
	#name : 'LuiPresenter',
	#superclass : 'LuiComponent',
	#instVars : [
		'model'
	],
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'testing' }
LuiPresenter >> isPresenterComponent [
	^ true
]

{ #category : 'accessing' }
LuiPresenter >> model [
	^ model
]

{ #category : 'accessing' }
LuiPresenter >> model: anObject [
	model := anObject
]

{ #category : 'rendering' }
LuiPresenter >> renderComponentOn: html [
	html section
		addCommonAttributes: self;
		with: [ self renderDetailsOn: html ]
]
