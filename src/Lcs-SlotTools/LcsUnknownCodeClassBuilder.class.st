Class {
	#name : #LcsUnknownCodeClassBuilder,
	#superclass : #LcsSingletonCodeClassBuilder,
	#category : #'Lcs-SlotTools'
}

{ #category : #ini }
LcsUnknownCodeClassBuilder >> initialize [
	super initialize.
	self defaultInstance: true.
	self codeDescription: ''.
	self shortName: ''.
	self codeName: 'unknown'
]
