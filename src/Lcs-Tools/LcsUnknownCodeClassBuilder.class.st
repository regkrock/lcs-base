Class {
	#name : #LcsUnknownCodeClassBuilder,
	#superclass : #LcsCodeClassBuilder,
	#category : #'Lcs-Tools'
}

{ #category : #ini }
LcsUnknownCodeClassBuilder >> initialize [
	super initialize.
	self defaultInstance: true.
	self codeDescription: ''.
	self shortName: ''.
	self codeName: 'unknown'
]
