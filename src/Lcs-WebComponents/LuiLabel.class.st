Class {
	#name : 'LuiLabel',
	#superclass : 'LuiFormInputComponent',
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'label' }
LuiLabel >> labelString [
	^ self attributes labelAttributeValue
]

{ #category : 'configuration' }
LuiLabel >> labelString: aString [
	self attributes labelAttribute value: aString
]

{ #category : 'rendering' }
LuiLabel >> renderComponentOn: html [
	html div
		addCommonAttributes: self;
		with: self labelString
]
