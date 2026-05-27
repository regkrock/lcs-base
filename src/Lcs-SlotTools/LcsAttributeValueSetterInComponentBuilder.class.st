Class {
	#name : 'LcsAttributeValueSetterInComponentBuilder',
	#superclass : 'LcsMethodBuilder',
	#instVars : [
		'attributeClassName'
	],
	#category : 'Lcs-SlotTools-Core',
	#package : 'Lcs-SlotTools',
	#tag : 'Core'
}

{ #category : 'command' }
LcsAttributeValueSetterInComponentBuilder >> _installCode [
	(self targetClass canUnderstand: self selector) ifTrue: [ ^ self ].
	(self isAlreadyImplementedInSuperclass: self selector) ifFalse: [
		super _installCode ]
]

{ #category : 'method code source' }
LcsAttributeValueSetterInComponentBuilder >> methodSource [
	"The following is an example of what should be generated
altText: anObject
	^ self attributes altText: anObject "
	
	^ '<1s> anObject
	^ self attributes <1s> anObject' expandMacrosWith: self selector
]
