Class {
	#name : 'LuiRequiredAttribute',
	#superclass : 'LuiComponentAttribute',
	#category : 'Lcs-WebComponents-Attributes',
	#package : 'Lcs-WebComponents',
	#tag : 'Attributes'
}

{ #category : 'constant' }
LuiRequiredAttribute class >> attributeName [
	^ 'required'
]

{ #category : 'as yet unclassified' }
LuiRequiredAttribute >> beOptional [
	self valueBlock: [ false ]
]

{ #category : 'api' }
LuiRequiredAttribute >> beRequired [
	self valueBlock: [ true ]
]

{ #category : 'initialize' }
LuiRequiredAttribute >> initialize [
	super initialize.
	self valueBlock: [ false ]
]

{ #category : 'testing' }
LuiRequiredAttribute >> isOptional [
	^ self isRequired ~~ true
]

{ #category : 'testing' }
LuiRequiredAttribute >> isRequired [
	^ self attributeValue == true
]
