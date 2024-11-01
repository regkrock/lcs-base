"
This class is for the input of mutli-line text. It is displayed on the UI using the ""<"" textarea "">""  tag.

The ""<""textarea "">"" defines a multi-line text input control.

Th<""textarea "">"" element is often used in a form, to collect user inputs like comments or reviews.

A text area can hold an unlimited number of characters, and the text renders in a fixed-width font (usually Courier).

The size of a text area is specified by the cols and rows attributes (or with CSS).

The name attribute is needed to reference the form data after the form is submitted (if you omit the name attribute, no data from the text area will be submitted).

The id attribute is needed to associate the text area with a label. 

Tip: Always add the ""<"" label "">"" tag for best accessibility practices!
"
Class {
	#name : #LuiTextArea,
	#superclass : #LuiInputComponent,
	#category : #'Lcs-WebComponents-Widgets'
}

{ #category : #rendering }
LuiTextArea >> renderComponentOn: html [
	html textArea
		addCommonProperties: self;
		callback: [ :value | Transcript cr; nextPutAll: ('entered: ' , value greaseString) ];
		value: self displayValue

]
