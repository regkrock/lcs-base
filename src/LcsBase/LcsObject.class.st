Class {
	#name : #LcsObject,
	#superclass : #Object,
	#category : #LcsBase
}

{ #category : #system }
LcsObject class >> currentSystem [

	^ LcsSystemManager currentSystem
]

{ #category : #accessing }
LcsObject class >> currentSystem: anObject [
	LcsSystemManager currentSystem: anObject
]

{ #category : #system }
LcsObject >> currentSystem [

	^ self class currentSystem
]

{ #category : #accessing }
LcsObject >> currentSystem: anObject [
	self class currentSystem: anObject
]
