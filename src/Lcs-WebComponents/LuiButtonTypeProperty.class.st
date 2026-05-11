Class {
	#name : 'LuiButtonTypeProperty',
	#superclass : 'LuiComponentProperty',
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'constants' }
LuiButtonTypeProperty class >> propertyName [
	^ 'buttonType'
]

{ #category : 'configuration' }
LuiButtonTypeProperty >> beButtonType [
	self valueBlock: [ 'button' ]
]

{ #category : 'configuration' }
LuiButtonTypeProperty >> beSubmitType [
	self valueBlock: [ 'submit' ]
]

{ #category : 'initialize' }
LuiButtonTypeProperty >> initialize [
	super initialize.
	self beButtonType.
	self tagAttributeSetSelector: #type:
]
