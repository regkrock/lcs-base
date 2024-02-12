Class {
	#name : #LcsObject,
	#superclass : #Object,
	#category : #LcsBase
}

{ #category : #system }
LcsObject class >> currentSystem [

	^LcsSystem singleton
]

{ #category : #system }
LcsObject >> currentSystem [

	^self class currentSystem
]
