Class {
	#name : 'LcsAttributeValueGetterInComponentBuilder',
	#superclass : 'LcsMethodBuilder',
	#instVars : [
		'attributeClassName'
	],
	#category : 'Lcs-SlotTools-Core',
	#package : 'Lcs-SlotTools',
	#tag : 'Core'
}

{ #category : 'command' }
LcsAttributeValueGetterInComponentBuilder >> _installCode [
	(self targetClass canUnderstand: self selector) ifTrue: [ ^ self ].
	(self isAlreadyImplementedInSuperclass: self selector) ifFalse: [
		super _installCode ]
]

{ #category : 'method code source' }
LcsAttributeValueGetterInComponentBuilder >> methodSource [
	"The following is an example of what should be generated
altText
	^ self attributes altText"
	
	^ '<1s>
	^ self attributes <1s>' expandMacrosWith: self selector
]
