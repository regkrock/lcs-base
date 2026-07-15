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

{ #category : 'instance creation' }
LuiPresenter class >> named: aComponentName model: aModel [
	^ self new
		componentName: aComponentName;
		model: aModel;
		yourself
]

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
	html div
		addCommonAttributes: self;
		with: [ self renderDetailsOn: html ]
]
