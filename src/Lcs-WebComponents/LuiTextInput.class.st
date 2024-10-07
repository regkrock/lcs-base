Class {
	#name : #LuiTextInput,
	#superclass : #LuiEnterableComponent,
	#category : #'Lcs-WebComponents-Widgets'
}

{ #category : #rendering }
LuiTextInput >> renderComponentOn: aRenderer [
	aRenderer textInput
		addCommonProperties: self;
		with: [ self displayValue ]
]
