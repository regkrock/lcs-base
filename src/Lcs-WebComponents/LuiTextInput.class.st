"
Tag type used: <input type=""text"" >  (WATextInputTag). Note the type=""text"" is the default so it is optional.


This is designed for entering a single line  vs a multi-line text. 
"
Class {
	#name : 'LuiTextInput',
	#superclass : 'LuiFormInputComponent',
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'defaults' }
LuiTextInput >> defaultCssClasses [
	^ #( 'inputField' )
]

{ #category : 'defaults' }
LuiTextInput >> displayValue [
	^ self valueAccessor displayValue
]

{ #category : 'initialize' }
LuiTextInput >> initializeNamed: aName [
	super initializeNamed: aName.
	self valueAccessor model: ''.
]

{ #category : 'initialize' }
LuiTextInput >> initializeOnSlot: aSlotDefinition [
	super initializeOnSlot: aSlotDefinition .
	self placeholder: aSlotDefinition label
]

{ #category : 'as yet unclassified' }
LuiTextInput >> renderComponentOn: html [
	html textInput
		addCommonAttributes: self;
		value: self displayValue
]
