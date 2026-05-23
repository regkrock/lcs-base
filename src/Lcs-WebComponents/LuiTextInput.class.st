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

{ #category : 'rendering' }
LuiTextInput >> displayValue [
	<todo: 'The first line is a hack. A solution is required for widgets which do not have a model associated with them.'>
	self valueAccessor isNil ifTrue: [ ^ '' ].
	^self valueAccessor displayValue
]

{ #category : 'initialize' }
LuiTextInput >> initializeOnSlot: aSlotDefinition on: aComponent [ 
	super initializeOnSlot: aSlotDefinition on: aComponent .
	"self properties name: aSlotDefinition slotName"
]

{ #category : 'as yet unclassified' }
LuiTextInput >> renderComponentOn: html [
	html textInput
		addCommonAttributes: self;
		value: self displayValue
]
