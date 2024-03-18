Class {
	#name : #LcsObject,
	#superclass : #Object,
	#category : #LcsBase
}

{ #category : #system }
LcsObject class >> currentSystem [

	^ #LcsSystemManager asClass currentSystem
]

{ #category : #system }
LcsObject class >> currentSystem: anObject [
	#LcsSystemManager asClass addNewSystem: anObject
]

{ #category : #system }
LcsObject >> currentSystem [

	^ self class currentSystem
]

{ #category : #system }
LcsObject >> currentSystem: anObject [
	self currentSystem: anObject
]
