Class {
	#name : 'LuiButtonTypeAttribute',
	#superclass : 'LuiComponentAttribute',
	#category : 'Lcs-WebComponents-Attributes',
	#package : 'Lcs-WebComponents',
	#tag : 'Attributes'
}

{ #category : 'constants' }
LuiButtonTypeAttribute class >> attributeName [
	^ 'buttonType'
]

{ #category : 'configuration' }
LuiButtonTypeAttribute >> beButtonType [
	self valueBlock: [ 'button' ]
]

{ #category : 'configuration' }
LuiButtonTypeAttribute >> beSubmitType [
	self valueBlock: [ 'submit' ]
]

{ #category : 'initialize' }
LuiButtonTypeAttribute >> initialize [
	super initialize.
	self beButtonType.
	self tagAttributeSetterSelector: #type:
]
