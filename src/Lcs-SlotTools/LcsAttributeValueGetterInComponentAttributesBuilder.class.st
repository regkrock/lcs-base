Class {
	#name : 'LcsAttributeValueGetterInComponentAttributesBuilder',
	#superclass : 'LcsMethodBuilder',
	#instVars : [
		'attributeName'
	],
	#category : 'Lcs-SlotTools-Core',
	#package : 'Lcs-SlotTools',
	#tag : 'Core'
}

{ #category : 'command' }
LcsAttributeValueGetterInComponentAttributesBuilder >> _installCode [
	(self targetClass canUnderstand: self selector) ifTrue: [ ^ self ].
	(self isAlreadyImplementedInSuperclass: self selector) ifFalse: [
		super _installCode ]
]

{ #category : 'method code source' }
LcsAttributeValueGetterInComponentAttributesBuilder >> methodSource [

	" This is an example of what shold be genearated
altText
	self hasAltTextAttribute ifFalse: [ ^ nil ].
	^ self altTextAttribute attributeValue"
	
	^ '<1s>
	self has<2s>Attribute ifFalse: [ ^ nil ].
	^ self <1s>Attribute attributeValue' expandMacrosWith: self selector with: self selector capitalized
	

]
