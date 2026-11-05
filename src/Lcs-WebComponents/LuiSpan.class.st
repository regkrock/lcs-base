Class {
	#name : 'LuiSpan',
	#superclass : 'LuiComponent',
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'gtview' }
LuiSpan >> gtViewOtherInfo [
	^ self text
]

{ #category : 'initialize' }
LuiSpan >> initialize [
	super initialize
]

{ #category : 'rendering' }
LuiSpan >> renderComponentOn: html [
	html span
		addCommonAttributes: self;
		with: [ self hasTextDecoration ifTrue: [ html text: self text ] ]
]
