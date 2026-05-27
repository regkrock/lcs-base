Class {
	#name : 'LcsComponentAttributeGetterBuilder',
	#superclass : 'LcsMethodBuilder',
	#category : 'Lcs-SlotTools-Core',
	#package : 'Lcs-SlotTools',
	#tag : 'Core'
}

{ #category : 'command' }
LcsComponentAttributeGetterBuilder >> _installCode [
	(self targetClass canUnderstand: self selector) ifTrue: [ ^ self ].
	(self isAlreadyImplementedInSuperclass: self selector) ifFalse: [
		super _installCode ]
]

{ #category : 'command' }
LcsComponentAttributeGetterBuilder >> methodSource [
	^ '<1s>
	^ self cachedValue' expandMacrosWith: self selector
]
