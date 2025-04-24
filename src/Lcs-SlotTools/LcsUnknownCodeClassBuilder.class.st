Class {
	#name : #LcsUnknownCodeClassBuilder,
	#superclass : #LcsSingletonCodeClassBuilder,
	#category : #'Lcs-SlotTools'
}

{ #category : #initialize }
LcsUnknownCodeClassBuilder >> initialize [
	super initialize.
	self defaultInstance: true.
	self description: ''.
	self label: ''.
	self code: 'unknown'
]
