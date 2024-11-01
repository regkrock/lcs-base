"
Tag type used: <input type=""text"" >  (WATextInputTag). Note the type=""text"" is the default so it is optional.


This is designed for entering a single line  vs a multi-line text. 
"
Class {
	#name : #LuiTextInput,
	#superclass : #LuiInputComponent,
	#category : #'Lcs-WebComponents-Widgets'
}

{ #category : #initialize }
LuiTextInput >> initializeOnSlot: aSlotDefinition on: aComponent [ 
	super initializeOnSlot: aSlotDefinition on: aComponent .
	self properties name: aSlotDefinition slotName
]

{ #category : #'as yet unclassified' }
LuiTextInput >> renderComponentOn: html [
	html textInput
		addCommonProperties: self;
		value: self displayValue
]
