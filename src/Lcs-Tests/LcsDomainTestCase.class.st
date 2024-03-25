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

{ #category : #running }
LcsDomainTestCase >> abortTransaction [
	LcsSmalltalkConfiguration gsSystemClass abortTransaction
]

{ #category : #running }
LcsDomainTestCase >> beginTransaction [
	LcsSmalltalkConfiguration gsSystemClass beginTransaction
]

{ #category : #running }
LcsDomainTestCase >> commitTransaction [
	LcsSmalltalkConfiguration gsSystemClass commitTransaction
]

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
	self abortTransaction	.
	LcsSystemManager singleton isNil ifTrue: [LcsSystemManager initializeEnvironment].
	self savedSystem: LcsSystemManager currentSystem.
	LcsSystemManager removeCurrentSystem.
	self setupSunitSystem.
	self commitTransaction.

]

{ #category : #accessing }
LcsDomainTestCase >> setupSunitSystem [
	"subclasses can override this method to create the system required for testing"
]

{ #category : #running }
LcsDomainTestCase >> tearDown [
	super tearDown.
	self abortTransaction.
	LcsSystemManager currentSystem: self savedSystem.
	self commitTransaction.

]
