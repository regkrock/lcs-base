Class {
	#name : #LcsSingletonUnknownCodeClassBuilder,
	#superclass : #LcsSingletonCodeClassBuilder,
	#category : #'Lcs-SlotTools'
}

{ #category : #initialize }
LcsSingletonUnknownCodeClassBuilder >> initialize [
	super initialize.
	self defaultInstance: true.
	self description: ''.
	self label: ''.
	self code: 'unknown'
]
