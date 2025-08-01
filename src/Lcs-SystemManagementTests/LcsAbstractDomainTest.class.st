"
Subclasses in:
1)  the  setUp phase of this test will suspend and save the current system.
2) the tearDwon phase will restore the suspended system.
"
Class {
	#name : #LcsAbstractDomainTest,
	#superclass : #LcsTestCase,
	#instVars : [
		'savedSystem'
	],
	#category : #'Lcs-SystemManagementTests-Tests'
}

{ #category : #asserting }
LcsAbstractDomainTest >> assertObject: anActualValue equals: aExectedValue [
	(anActualValue isBlock and: [ aExectedValue isBlock ]) 
		ifTrue: [ 
			self assert: anActualValue asString equals: aExectedValue asString.
			^self ].
		self assert: anActualValue equals: aExectedValue
]

{ #category : #'application environment' }
LcsAbstractDomainTest >> currentSystem [
	^ LcsApplicationEnvironment currentSystem
]

{ #category : #'application environment' }
LcsAbstractDomainTest >> currentSystemUnitOfWork [
	^ (LcsApplicationEnvironment currentSystem)
		ifNotNil: [ :cur | cur unitOfWork ]
]

{ #category : #'application environment' }
LcsAbstractDomainTest >> currentUnitOfWork [
	^ LcsApplicationEnvironment currentUnitOfWork
]

{ #category : #accessing }
LcsAbstractDomainTest >> savedSystem [
	^ savedSystem
]

{ #category : #accessing }
LcsAbstractDomainTest >> savedSystem: aSystem [
	savedSystem := aSystem
]

{ #category : #running }
LcsAbstractDomainTest >> setUp [
	super setUp.
	self abortTransaction.
	LcsApplicationEnvironment ensureInitialized.
	self savedSystem: LcsApplicationEnvironment suspendCurrentSystem.
	self setUpTestSystem.
	self commitTransaction
]

{ #category : #setUp }
LcsAbstractDomainTest >> setUpTestSystem [
	"This does not setup a test system"
]

{ #category : #'application environment' }
LcsAbstractDomainTest >> systemsManager [
	^ LcsApplicationEnvironment systemsManager
]

{ #category : #running }
LcsAbstractDomainTest >> tearDown [
	super tearDown.
	self abortTransaction.
	self savedSystem isNil 
		ifTrue: [
			LcsApplicationEnvironment removeCurrentSystem.
			self assert: self currentSystem isNil ]
		ifFalse: [
			LcsApplicationEnvironment deleteCurrentAndMakeCurrent: self savedSystem.
		self assert: self currentSystem identicalTo: self savedSystem ].
	self commitTransaction.

]

{ #category : #'application environment' }
LcsAbstractDomainTest >> unitsOfWorkManager [
	^ LcsApplicationEnvironment unitsOfWorkManager
]
