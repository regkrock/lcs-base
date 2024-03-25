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
	self singleton ifNotNil: [self releaseEnvironment].
	LcsUnitOfWorkManager initializeEnvironment.
	self singleton ifNil: [ Singleton := self new ].
	^self singleton

]

{ #category : #accessing }
LcsSystemManager class >> releaseEnvironment [
	LcsUnitOfWorkManager releaseEnvironment.
	self singleton ifNil: [^self].
	self singleton releaseEnvironment.
	self singleton: nil
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
