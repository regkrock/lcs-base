Class {
	#name : 'LcsObjectExamples',
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
LcsObjectExamples >> clearUnitOfWork [
	self currentSystem isNil ifTrue: [ ^ self ].
	self currentSystem clearUnitOfWork
]

{ #category : 'system support' }
LcsObjectExamples >> currentSystem [
	^ LcsApplicationEnvironment currentSystem
]

{ #category : 'system support' }
LcsObjectExamples >> currentUnitOfWork [
	^ (self currentSystem ifNil: [ ^ nil ]) unitOfWork
]

{ #category : 'system support' }
LcsObjectExamples >> ensureCurrentSystemIsSailingClubSystem [
	^ LcsApplicationEnvironment ensureCurrentSystemIs: LcsSailingClubSystem
]

{ #category : 'system support' }
LcsObjectExamples >> ensureNoCurrentSystem [
	self assert: LcsApplicationEnvironment isInActiveStatus.
	self savedSystem: self currentSystem.
	self currentSystem ifNotNil: [ self currentSystem suspendSystem ]
]

{ #category : 'system support' }
LcsObjectExamples >> removeCurrentSystem [
	^ LcsApplicationEnvironment removeCurrentSystem
]

{ #category : 'system support' }
LcsObjectExamples >> removeCurrentSystemAndActivate: aSuspendedSystem [
	LcsApplicationEnvironment removeCurrentSystemAndActivate: aSuspendedSystem
]

{ #category : 'system support' }
LcsObjectExamples >> removeCurrentSystemAndActivateSavedSystem [
	self removeCurrentSystemAndActivate: self savedSystem
]

{ #category : 'accessing' }
LcsObjectExamples >> savedSystem [
	^ savedSystem
]

{ #category : 'accessing' }
LcsObjectExamples >> savedSystem: anObject [
	savedSystem := anObject
]

{ #category : 'accessing' }
LcsObjectExamples >> subject [
	^ subject
]

{ #category : 'accessing' }
LcsObjectExamples >> subject: anObject [
	subject := anObject
]

{ #category : 'system support' }
LcsObjectExamples >> systemsManager [
	^ LcsApplicationEnvironment systemsManager
]

{ #category : 'system support' }
LcsObjectExamples >> unitsOfWorkManager [
	^ LcsApplicationEnvironment unitsOfWorkManager
]
