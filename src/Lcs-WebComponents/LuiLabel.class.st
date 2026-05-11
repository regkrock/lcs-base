Class {
	#name : 'LuiLabel',
	#superclass : 'LuiInputComponent',
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'label' }
LuiLabel >> labelString [
	^ self properties labelPropertyValue
]

{ #category : 'configuration' }
LuiLabel >> labelString: aString [
	self properties labelProperty value: aString
]

{ #category : 'rendering' }
LuiLabel >> renderComponentOn: html [
	html div
		addCommonProperties: self;
		with: self labelString
]
