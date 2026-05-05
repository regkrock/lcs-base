"
<https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/for>

This links fields together. For example, aLabel and its related input field.

Ex: The label is identified as being for username
<label for=""username"">Your name</label> <input type=""text"" id=""username"" />
"
Class {
	#name : 'LuiForNameProperty',
	#superclass : 'LuiComponentProperty',
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'constants' }
LuiForNameProperty class >> propertyName [
	^ 'forName'
]

{ #category : 'accessing' }
LuiForNameProperty >> for: aString [
	self valueBlock: [ aString ]
]
