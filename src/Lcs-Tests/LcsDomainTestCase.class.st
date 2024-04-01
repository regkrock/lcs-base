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

{ #category : #'application environment' }
LcsDomainTestCase >> currentSystem [
	^ LcsApplicationEnvironment currentSystem
]

{ #category : #'application environment' }
LcsDomainTestCase >> currentUnitOfWork [
	^ LcsApplicationEnvironment currentUnitOfWork
]

{ #category : #accessing }
LcsDomainTestCase >> savedSystem [
	^ savedSystem
]

{ #category : #accessing }
LcsDomainTestCase >> savedSystem: aSystem [
	savedSystem := aSystem
]

{ #category : #running }
LcsDomainTestCase >> setUp [
	super setUp.
	self abortTransaction.
	LcsApplicationEnvironment ensureInitialized.
	self savedSystem: LcsApplicationEnvironment suspendCurrentSystem.
	self setupSunitSystem.
	self commitTransaction
]

{ #category : #running }
LcsDomainTestCase >> setupSunitSystem [
	"subclasses can override this method to create the system required for testing"
]

{ #category : #'application environment' }
LcsDomainTestCase >> systemManager [
	^ LcsApplicationEnvironment systemManager
]

{ #category : #running }
LcsDomainTestCase >> tearDown [
	super tearDown.
	self abortTransaction.
	LcsApplicationEnvironment removeCurrentSystemAndRevertTo: self savedSystem. 
	self commitTransaction.

]

{ #category : #'application environment' }
LcsDomainTestCase >> unitsOfWorkManager [
	^ LcsApplicationEnvironment unitsOfWorkManager
]
