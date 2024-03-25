Class {
	#name : #LcsSystemManager,
	#superclass : #LcsObject,
	#instVars : [
		'currentSystem'
	],
	#classInstVars : [
		'Singleton'
	],
	#category : #'Lcs-SystemManagement'
}

{ #category : #system }
LcsSystemManager class >> addNewSystem: aSystem [
	self singleton addNewSystem: aSystem 
]

{ #category : #accessing }
LcsSystemManager class >> clearCurrentSystem [
	(self singleton ifNil: [ ^ self ]) clearCurrentSystem
]

{ #category : #accessing }
LcsSystemManager class >> clearCurrentUnitOfWork [
	LcsUnitOfWorkManager clearCurrentUnitOfWork
]

{ #category : #'instance creation' }
LcsSystemManager class >> createUnitOfWork [
	LcsUnitOfWorkManager createUnitOfWork
]

{ #category : #accessing }
LcsSystemManager class >> currentSystem [
	^ (self singleton ifNil: [ ^ nil ] ) currentSystem
]

{ #category : #accessing }
LcsSystemManager class >> currentSystem: aSystem [
	self singleton currentSystem: aSystem
]

{ #category : #accessing }
LcsSystemManager class >> currentUnitOfWork [
	^ LcsUnitOfWorkManager currentUnitOfWork
]

{ #category : #initialize }
LcsSystemManager class >> initializeEnvironment [
	LcsSmalltalkConfiguration gsSystemClass abortTransaction.
	self singleton ifNotNil: [self releaseEnvironment].
	LcsUnitOfWorkManager initializeEnvironment.
	self singleton ifNil: [ Singleton := self new ].
	LcsSmalltalkConfiguration gsSystemClass commitTransaction.
	^self singleton

]

{ #category : #accessing }
LcsSystemManager class >> releaseEnvironment [
	self abortTransaction.
	LcsUnitOfWorkManager releaseEnvironment.
	self singleton ifNil: [ ^ self ].
	self singleton releaseEnvironment.
	self singleton: nil.
	self commitTransaction
]

{ #category : #accessing }
LcsSystemManager class >> singleton [
	^ Singleton
]

{ #category : #accessing }
LcsSystemManager class >> singleton: anObject [
	Singleton := anObject
]

{ #category : #accessing }
LcsSystemManager >> addNewSystem: aSystem [
	aSystem parent: self.
	self currentSystem: aSystem
]

{ #category : #accessing }
LcsSystemManager >> clearCurrentSystem [
	LcsUnitOfWorkManager clearUnitOfWorkFor: self currentSystem.
	self currentSystem: nil
]

{ #category : #accessing }
LcsSystemManager >> currentSystem [
	^ currentSystem
]

{ #category : #accessing }
LcsSystemManager >> currentSystem: anObject [
	currentSystem := anObject
]

{ #category : #accessing }
LcsSystemManager >> releaseEnvironment [
	self clearCurrentSystem
]
