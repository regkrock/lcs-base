"
Tag type used: <input type=""text"" >  (WATextInputTag). Note the type=""text"" is the default so it is optional.


This is designed for entering a single line  vs a multi-line text. 
"
Class {
	#name : 'LuiTextInput',
	#superclass : 'LuiAbstractTextAreaComponent',
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

{ #category : 'gt views' }
LuiTextInput >> gtViewTagName [
	^ super gtViewTagName , ' type=''text'''
]

{ #category : 'callbacks' }
LuiTextInput >> handleCallbackValue: value [ 
	self valueAccessor write: value
]

{ #category : 'initialize' }
LuiTextInput >> initializeNamed: aName [
	super initializeNamed: aName.
	self valueAccessor model: ''.
]

{ #category : 'initialize' }
LuiTextInput >> initializeOnSlot: aSlotDefinition model: aModel componentName: aString [
	super initializeOnSlot: aSlotDefinition model: aModel componentName: aString.
	self placeholder: aSlotDefinition label
]

{ #category : 'rendering' }
LuiTextInput >> renderComponentOn: html [
	html textInput
		addCommonAttributes: self;
		value: self displayValue
]
