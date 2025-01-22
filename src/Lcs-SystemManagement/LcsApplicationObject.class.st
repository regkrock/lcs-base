Class {
	#name : #LcsApplicationObject,
	#superclass : #LcsObject,
	#category : #'Lcs-SystemManagement-Environment'
}

{ #category : #environment }
LcsApplicationObject class >> currentSystem [
	^ LcsApplicationEnvironment currentSystem
]

{ #category : #environment }
LcsApplicationObject class >> currentUnitOfWork [
	^ self currentSystem ifNotNil: [:system | system currentUnitOfWork ]
]

{ #category : #environment }
LcsApplicationObject >> currentSystem [
	^ self class currentSystem
]

{ #category : #environment }
LcsApplicationObject >> currentUnitOfWork [
	^ self class currentUnitOfWork
]
