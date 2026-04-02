Class {
	#name : 'LcsExamples',
	#superclass : 'LcsObject',
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#instVars : [
		'subject',
		'savedSystem'
	],
	#category : 'Lcs-BaseTests-Examples',
	#package : 'Lcs-BaseTests',
	#tag : 'Examples'
}

{ #category : 'system support' }
LcsExamples >> abortTransaction [
	System abortTransaction
]

{ #category : 'asserting' }
LcsExamples >> assertClass: aClassOrClassName hasClassSelector: aSelector [
	self assert: ((self classNamed:aClassOrClassName) class allSelectors includes: aSelector asSymbol)
]

{ #category : 'asserting' }
LcsExamples >> assertClass: aClassOrClassName hasLocalClassSelector: aSelector [
	self assert: ((self classNamed:aClassOrClassName) class selectors includes: aSelector asSymbol)
]

{ #category : 'asserting' }
LcsExamples >> assertClass: aClassOrClassName hasLocalSelector: aSelector [
	self assert: ((self classNamed:aClassOrClassName) selectors includes: aSelector asSymbol)
]

{ #category : 'asserting' }
LcsExamples >> assertClass: aClassOrClassName hasSelector: aSelector [
	self assert: ((self classNamed:aClassOrClassName) allSelectors includes: aSelector asSymbol)
]

{ #category : 'asserting' }
LcsExamples >> assertClassDoesntExist: aString [
	self should: [ aString asClass ] raise: NotFound
]

{ #category : 'asserting' }
LcsExamples >> assertClassExists: aString [
	self shouldnt: [ aString asClass ] raise: NotFound
]

{ #category : 'asserting' }
LcsExamples >> assertObject: anActualValue equals: aExectedValue [
	(anActualValue isBlock and: [ aExectedValue isBlock ]) 
		ifTrue: [ 
			self assert: anActualValue asString equals: aExectedValue asString.
			^self ].
	((anActualValue isKindOf: LcsUpdateActions) and: [ aExectedValue isKindOf: LcsUpdateActions ] ) 
		ifTrue: [
			self assert: (anActualValue isSameAs: aExectedValue).
			^ self ].
	self assert: anActualValue equals: aExectedValue
]

{ #category : 'system support' }
LcsExamples >> beginTransaction [
	System beginTransaction
]

{ #category : 'tearDown' }
LcsExamples >> clearUnitOfWork [
	Transcript cr; show: #tearDown.
	self currentSystem clearUnitOfWork.
	self assert: (self currentSystem ifNil: [ true  ] ifNotNil: [ self currentSystem unitOfWork hasNoChanges ])
]

{ #category : 'tearDown' }
LcsExamples >> clearUnitOfWorkAndRestoreSavedSystem [
	Transcript cr; show: #tearDown.
	self currentSystem clearUnitOfWork.
	self assert: (self currentSystem ifNil: [ true  ] ifNotNil: [ self currentSystem unitOfWork hasNoChanges ]).
	LcsApplicationEnvironment makeSystemCurrent: self savedSystem
]

{ #category : 'system support' }
LcsExamples >> commitTransaction [
	System commitTransaction
]

{ #category : 'system support' }
LcsExamples >> currentSystem [
	^ LcsApplicationEnvironment currentSystem
]

{ #category : 'system support' }
LcsExamples >> currentUnitOfWork [
	^ (self currentSystem ifNil: [ ^ nil ]) unitOfWork
]

{ #category : 'asserting' }
LcsExamples >> denyClass: aClassOrClassName hasClassSelector: aSelector [
	self deny: ((self classNamed:aClassOrClassName) class allSelectors includes: aSelector asSymbol)
]

{ #category : 'asserting' }
LcsExamples >> denyClass: aClassOrClassName hasLocalClassSelector: aSelector [
	self deny: ((self classNamed:aClassOrClassName) class selectors includes: aSelector asSymbol)
]

{ #category : 'asserting' }
LcsExamples >> denyClass: aClassOrClassName hasLocalSelector: aSelector [
	self deny: ((self classNamed:aClassOrClassName) selectors includes: aSelector asSymbol)
]

{ #category : 'asserting' }
LcsExamples >> denyClass: aClassOrClassName hasSelector: aSelector [
	self deny: ((self classNamed:aClassOrClassName) allSelectors includes: aSelector asSymbol)
]

{ #category : 'system support' }
LcsExamples >> ensureCurrentSystemIsSailingClubSystem [
	^ LcsApplicationEnvironment ensureCurrentSystemIs: LcsSailingClubSystem
]

{ #category : 'system support' }
LcsExamples >> ensureNoCurrentSystem [
	LcsApplicationEnvironment isStopped
		ifTrue: [  LcsApplicationEnvironment initializeApplicationEnvironment].
	self savedSystem: self currentSystem.
	self currentSystem ifNotNil: [ 
		self currentSystem suspendSystem ].
	^ self savedSystem
]

{ #category : 'system support' }
LcsExamples >> removeCurrentSystem [
	^ LcsApplicationEnvironment removeCurrentSystem
]

{ #category : 'system support' }
LcsExamples >> removeCurrentSystemAndActivate: aSuspendedSystem [
	LcsApplicationEnvironment removeCurrentSystemAndActivate: aSuspendedSystem
]

{ #category : 'system support' }
LcsExamples >> removeCurrentSystemAndActivateSavedSystem [
	self removeCurrentSystemAndActivate: self savedSystem
]

{ #category : 'accessing' }
LcsExamples >> savedSystem [
	^ savedSystem
]

{ #category : 'accessing' }
LcsExamples >> savedSystem: anObject [
	savedSystem := anObject
]

{ #category : 'accessing' }
LcsExamples >> subject [
	^ subject
]

{ #category : 'accessing' }
LcsExamples >> subject: anObject [
	subject := anObject
]

{ #category : 'system support' }
LcsExamples >> systemsManager [
	^ LcsApplicationEnvironment systemsManager
]

{ #category : 'system support' }
LcsExamples >> unitsOfWorkManager [
	^ LcsApplicationEnvironment unitsOfWorkManager
]
