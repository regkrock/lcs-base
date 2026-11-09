Class {
	#name : 'LuiForm',
	#superclass : 'LuiComponent',
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

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

{ #category : 'testing' }
LuiForm >> isFormComponent [
	^ true
]

{ #category : 'rendering' }
LuiForm >> renderComponentOn: html [
	html form
		addCommonAttributes: self;
		with: [ self renderDetailsOn: html ]
]
