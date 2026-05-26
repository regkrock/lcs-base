Class {
	#name : 'LuiForm',
	#superclass : 'LuiComponent',
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'instance creation' }
LuiForm class >> newWith: aComponent [
	^ super new
		addComponent: aComponent;
		yourself
]

{ #category : 'initialize' }
LuiForm >> componentAttributesClass [
	^ LuiFormAttributes
]

{ #category : 'defaults' }
LuiForm >> defaultComponentName [
	^ 'form'
]

{ #category : 'initialize' }
LuiForm >> initialize [
	super initialize.
	self componentName: self defaultComponentName
]

{ #category : 'rendering' }
LuiForm >> renderComponentOn: html [
	html form
		addCommonAttributes: self;
		with: [ self renderDetailsOn: html ]
]
