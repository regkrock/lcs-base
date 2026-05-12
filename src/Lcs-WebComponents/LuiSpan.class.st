Class {
	#name : 'LuiSpan',
	#superclass : 'LuiComponent',
	#traits : 'LtText',
	#classTraits : 'LtText classTrait',
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'initialize' }
LuiSpan >> initialize [
	super initialize.
	self valueBlock: [ '' ]
]

{ #category : 'rendering' }
LuiSpan >> renderComponentOn: html [
	html span
		addCommonAttributes: self;
		with: [ html text: self text ]
		
]
