Class {
	#name : 'LcsAttributeGetterInComponentAttributesBuilder',
	#superclass : 'LcsMethodBuilder',
	#instVars : [
		'attributeClassName'
	],
	#category : 'Lcs-SlotTools-Core',
	#package : 'Lcs-SlotTools',
	#tag : 'Core'
}

{ #category : 'command' }
LcsAttributeGetterInComponentAttributesBuilder >> _installCode [
	(self targetClass canUnderstand: self selector) ifTrue: [ ^ self ].
	(self isAlreadyImplementedInSuperclass: self selector) ifFalse: [
		super _installCode ]
]

{ #category : 'accessing' }
LcsAttributeGetterInComponentAttributesBuilder >> attributeClassName [
	^ attributeClassName
]

{ #category : 'accessing' }
LcsAttributeGetterInComponentAttributesBuilder >> attributeClassName: anObject [
	attributeClassName := anObject
]

{ #category : 'method code source' }
LcsAttributeGetterInComponentAttributesBuilder >> methodSource [
	"The following is an example of what should be generated
altTextAttribute
	^ self lazyInitializedAttribute: LuiAltTextAttribute"

	^ '<1s>
	^ self lazyInitializedAttribute: <2s>' expandMacrosWith: self selector with: self attributeClassName
]
