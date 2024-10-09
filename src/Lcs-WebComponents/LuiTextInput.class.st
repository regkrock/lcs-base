Class {
	#name : #LuiTextInput,
	#superclass : #LuiEnterableComponent,
	#category : #'Lcs-WebComponents-Widgets'
}

{ #category : #rendering }
LuiTextInput >> renderComponentOn: html [
	html textInput
		addCommonProperties: self;
		value: self displayValue;
		callback: [ :value | Transcript cr; nextPutAll: ('entered: ' , value greaseString) ]
]
