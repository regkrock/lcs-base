Class {
	#name : #LcsObject,
	#superclass : #Object,
	#category : #LcsBase
}

{ #category : #accessing }
LcsObject class >> currentSystem [

	^LcsSystem singleton
]

{ #category : #accessing }
LcsObject >> currentSystem [

	^self class currentSystem
]

{ #category : #accessing }
LcsObject >> readMe [

	^'Hello'
]
