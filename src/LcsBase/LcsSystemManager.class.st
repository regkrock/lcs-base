Class {
	#name : #LcsSystemManager,
	#superclass : #LcsObject,
	#category : #LcsBase
}

{ #category : #accessing }
LcsSystemManager class >> clearCurrentSystem [
	self currentSystem: nil
]

{ #category : #accessing }
LcsSystemManager class >> createNewPrototypeSystem [
	self currentSystem: #LxxPrototypeSystem asClass newSystem
]

{ #category : #accessing }
LcsSystemManager class >> createNewSystem [
	^ #LcsSystem asClass newSystem
]

{ #category : #'instance creation' }
LcsSystemManager class >> createUnitOfWork [
	self currentUnitOfWork: (#LcsUnitOfWork asClass newOn: self)
]

{ #category : #accessing }
LcsSystemManager class >> currentSystem [
	^ LcsSmalltalkConfiguration systemDictionary at: #LcsCurrentSystemInstance ifAbsent: [nil]
]

{ #category : #accessing }
LcsSystemManager class >> currentSystem: aSystem [
	LcsSmalltalkConfiguration systemDictionary at: #LcsCurrentSystemInstance put: aSystem
]

{ #category : #accessing }
LcsSystemManager class >> currentUnitOfWork [
	^ LcsSmalltalkConfiguration systemDictionary at: #LcsCurrentUnitOfWork ifAbsent: [ nil ]
]

{ #category : #accessing }
LcsSystemManager class >> currentUnitOfWork: aUnitOfWork [
	LcsSmalltalkConfiguration systemDictionary at: #LcsCurrentUnitOfWork put: aUnitOfWork
]
