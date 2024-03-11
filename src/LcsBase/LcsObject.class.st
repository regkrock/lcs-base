Class {
	#name : #LcsObject,
	#superclass : #Object,
	#category : #LcsBase
}

{ #category : #system }
LcsObject class >> currentSystem [

	^ LcsSystemManager currentSystem
]

{ #category : #system }
LcsObject class >> currentSystem: anObject [
	LcsSystemManager currentSystem: anObject
]

{ #category : #system }
LcsObject >> currentSystem [

	^ self class currentSystem
]

{ #category : #system }
LcsObject >> currentSystem: anObject [
	self class currentSystem: anObject
]
