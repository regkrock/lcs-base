Class {
	#name : #LcsObject,
	#superclass : #Object,
	#category : #LcsBase
}

{ #category : #system }
LcsObject class >> currentSystem [

	^#LcsSystem asClass singleton
]

{ #category : #system }
LcsObject >> currentSystem [

	^self class currentSystem
]
