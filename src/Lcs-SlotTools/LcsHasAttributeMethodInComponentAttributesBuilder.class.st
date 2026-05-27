Class {
	#name : 'LcsHasAttributeMethodInComponentAttributesBuilder',
	#superclass : 'LcsMethodBuilder',
	#instVars : [
		'attributeClassName'
	],
	#category : 'Lcs-SlotTools-Core',
	#package : 'Lcs-SlotTools',
	#tag : 'Core'
}

{ #category : 'command' }
LcsHasAttributeMethodInComponentAttributesBuilder >> _installCode [
	(self targetClass canUnderstand: self selector) ifTrue: [ ^ self ].
	(self isAlreadyImplementedInSuperclass: self selector) ifFalse: [
		super _installCode ]
]

{ #category : 'accessing' }
LcsHasAttributeMethodInComponentAttributesBuilder >> attributeClassName [
	^ attributeClassName
]

{ #category : 'accessing' }
LcsHasAttributeMethodInComponentAttributesBuilder >> attributeClassName: anObject [
	attributeClassName := anObject
]

{ #category : 'method code source' }
LcsHasAttributeMethodInComponentAttributesBuilder >> methodSource [
	^ '<1s>
	^ self hasAttribute: <2s> attributeName'
		expandMacrosWith: self selector
		with: self attributeClassName
]
