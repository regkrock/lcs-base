"
<https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/for>

This links fields together. For example, aLabel and its related input field.

Ex: The label is identified as being for username
<label for=""username"">Your name</label> <input type=""text"" id=""username"" />
"
Class {
	#name : 'LuiForNameAttribute',
	#superclass : 'LuiComponentAttribute',
	#category : 'Lcs-WebComponents-Attributes',
	#package : 'Lcs-WebComponents',
	#tag : 'Attributes'
}

{ #category : 'constants' }
LuiForNameAttribute class >> attributeName [
	^ 'forName'
]

{ #category : 'accessing' }
LuiForNameAttribute >> for: aString [
	self valueBlock: [ aString ]
]

{ #category : 'initialize' }
LuiForNameAttribute >> initialize [
	super initialize.
	self tagAttributeSetterSelector: #'for:'
]
