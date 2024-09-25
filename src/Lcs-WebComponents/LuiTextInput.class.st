Class {
	#name : #LuiTextInput,
	#superclass : #LuiComponent,
	#category : #'Lcs-WebComponents'
}

{ #category : #rendering }
LuiTextInput >> renderComponentOn: aRenderer [
	aRenderer textInput
		id: self componentId;
		class: self cssClassesString;
		with: [ self displayValue ]
]
