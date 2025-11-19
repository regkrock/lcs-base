Class {
	#name : 'LcsSingletonUnknownValueObjectClassBuilder',
	#superclass : 'LcsSingletonValueObjectClassBuilder',
	#category : 'Lcs-SlotTools',
	#package : 'Lcs-SlotTools'
}

{ #category : 'initialize' }
LcsSingletonUnknownValueObjectClassBuilder >> initialize [
	super initialize.
	self defaultInstance: true.
	self description: ''.
	self label: ''.
	self code: 'unknown'
]
