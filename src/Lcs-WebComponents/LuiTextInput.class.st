Class {
	#name : #LuiTextInput,
	#superclass : #LuiComponent,
	#category : #'Lcs-WebComponents-Widgets'
}

{ #category : #rendering }
LuiTextInput >> renderComponentOn: aRenderer [
	aRenderer textInput
		id: self componentId;
		class: self cssClassesString;
		dataName: self componentName;
		dataStClass: self;
		with: [ self displayValue ]
]
