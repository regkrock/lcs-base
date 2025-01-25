Class {
	#name : #LcsApplicationObject,
	#superclass : #LcsObject,
	#category : #'Lcs-SystemManagement-Environment'
}

{ #category : #system }
LcsApplicationObject class >> currentSystem [
	^ LcsApplicationEnvironment currentSystem
]

{ #category : #system }
LcsApplicationObject class >> currentUnitOfWork [
	^ self currentSystem ifNotNil: [:system | system currentUnitOfWork ]
]

{ #category : #system }
LcsApplicationObject >> currentSystem [
	^ self class currentSystem
]

{ #category : #system }
LcsApplicationObject >> currentUnitOfWork [
	^ self class currentUnitOfWork
]
