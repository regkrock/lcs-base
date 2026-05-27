Class {
	#name : 'LcsComponentAttributeSetterBuilder',
	#superclass : 'LcsMethodBuilder',
	#category : 'Lcs-SlotTools-Core',
	#package : 'Lcs-SlotTools',
	#tag : 'Core'
}

{ #category : 'command' }
LcsComponentAttributeSetterBuilder >> _installCode [
	(self targetClass canUnderstand: self selector) ifTrue: [ ^ self ].
	(self isAlreadyImplementedInSuperclass: self selector) ifFalse: [
		super _installCode ]
]

{ #category : 'command' }
LcsComponentAttributeSetterBuilder >> methodSource [
	^ '<1s> anObject
	^ self valueBlock: [ anObject ]' expandMacrosWith: self selector
]
