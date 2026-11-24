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
		initializeComponentName: aComponentName model: aModel;
		yourself
]

{ #category : 'buiilding' }
LuiPresenter >> buildComponents [
	"this should be overwritten to add subcomponents to the presenter"
]

{ #category : 'initialize' }
LuiPresenter >> initializeComponentName: aComponentName model: aModel [
	self
		componentName: aComponentName;
		model: aModel.
	self buildComponents

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
