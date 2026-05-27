Class {
	#name : 'LcsAttributeValueSetterInComponentAttributesBuilder',
	#superclass : 'LcsMethodBuilder',
	#instVars : [
		'attributeName'
	],
	#category : 'Lcs-SlotTools-Core',
	#package : 'Lcs-SlotTools',
	#tag : 'Core'
}

{ #category : 'command' }
LcsAttributeValueSetterInComponentAttributesBuilder >> _installCode [
	(self targetClass canUnderstand: self selector) ifTrue: [ ^ self ].
	(self isAlreadyImplementedInSuperclass: self selector) ifFalse: [
		super _installCode ]
]

{ #category : 'accessing' }
LcsAttributeValueSetterInComponentAttributesBuilder >> attributeName [
	^ attributeName
]

{ #category : 'accessing' }
LcsAttributeValueSetterInComponentAttributesBuilder >> attributeName: anObject [
	attributeName := anObject
]

{ #category : 'method code source' }
LcsAttributeValueSetterInComponentAttributesBuilder >> methodSource [

	" This is an example of what shold be genearated
altText: anObject
	self altTextAttribute altText: anObject"
	
	^ '<1s> anObject
	self <2s>Attribute <1s> anObject' expandMacrosWith: self selector with: self attributeName
]
