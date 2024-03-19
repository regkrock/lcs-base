"
Tests inheriting from this class have the current 'System' saved in the #setUP and it will be restored in the #tearDown phase.
"
Class {
	#name : #LcsDomainTestCase,
	#superclass : #LcsTestCase,
	#instVars : [
		'savedSystem'
	],
	#category : #'Lcs-Tests'
}

{ #category : #accessing }
LcsDomainTestCase >> currentSystem [
	^ LcsSystemManager currentSystem
]

{ #category : #accessing }
LcsDomainTestCase >> currentUnitOfWork [
	^ self currentSystem currentUnitOfWork
]

{ #category : #accessing }
LcsDomainTestCase >> savedSystem [
	^ savedSystem
]

{ #category : #accessing }
LcsDomainTestCase >> savedSystem: anObject [
	savedSystem := anObject
]

{ #category : #running }
LcsDomainTestCase >> setUp [
	super setUp.
	LcsSystemManager singleton isNil ifTrue: [LcsSystemManager initializeEnvironment].
	LcsUnitOfWorkManager singleton isNil ifTrue: [LcsUnitOfWorkManager initializeEnvironment].
	self savedSystem: LcsSystemManager currentSystem.
	LcsSystemManager clearCurrentSystem.
]

{ #category : #running }
LcsDomainTestCase >> tearDown [
	super tearDown.
	LcsSystemManager currentSystem: self savedSystem
]
