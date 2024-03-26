Class {
	#name : #LcsSystemManager,
	#superclass : #LcsObject,
	#instVars : [
		'parent'
	],
	#classInstVars : [
		'Singleton'
	],
	#category : #'Lcs-SystemManagement'
}

{ #category : #system }
LcsSystemManager class >> addNewSystem: aSystem [
	LcsApplicationEnvironment currentApplicationEnvironment addNewSystem: aSystem 
]

{ #category : #accessing }
LcsSystemManager class >> clearCurrentUnitOfWork [
	LcsUnitOfWorkManager clearCurrentUnitOfWork
]

{ #category : #'instance creation' }
LcsSystemManager class >> createUnitOfWork [
	LcsApplicationEnvironment createUnitOfWork
]

{ #category : #accessing }
LcsSystemManager class >> currentSystem [
	^ LcsApplicationEnvironment currentSystem
]

{ #category : #accessing }
LcsSystemManager class >> currentSystem: aSystem [
	LcsApplicationEnvironment currentSystem: aSystem
]

{ #category : #accessing }
LcsSystemManager class >> currentUnitOfWork [
	^ LcsApplicationEnvironment currentUnitOfWork
]

{ #category : #accessing }
LcsSystemManager class >> hasCurrentSystem [
	^ self singleton notNil and: [ self singleton hasCurrentSystem ]
]

{ #category : #accessing }
LcsSystemManager class >> hasNoCurrentSystem [
	^ self singleton isNil or: [ self singleton hasNoCurrentSystem ]
]

{ #category : #running }
LcsSystemManager class >> makeCurrentSystem: aSystem [ 
	LcsApplicationEnvironment currentApplicationEnvironment makeCurrentSystem: aSystem
]

{ #category : #accessing }
LcsSystemManager class >> newOn: anAppicaltionEnvironment [
	^ self new
		initializeOn: anAppicaltionEnvironment;
		yourself
]

{ #category : #accessing }
LcsSystemManager class >> removeCurrentSystem [
	LcsApplicationEnvironment removeCurrentSystem
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
LcsSystemManager >> currentSystem [
	^ currentSystem
]

{ #category : #accessing }
LcsSystemManager >> currentSystem: anObject [
	currentSystem := anObject
]

{ #category : #accessing }
LcsSystemManager >> hasCurrentSystem [
	^self currentSystem notNil
]

{ #category : #accessing }
LcsSystemManager >> hasNoCurrentSystem [
	^self currentSystem isNil
]

{ #category : #accessing }
LcsSystemManager >> initializeOn: anAppicaltionEnvironment [ 
	self parent: anAppicaltionEnvironment 
]

{ #category : #accessing }
LcsSystemManager >> makeCurrentSystem: aSystem [
	self currentSystem: aSystem.
	self currentSystem restoreSlotModel
]

{ #category : #accessing }
LcsSystemManager >> parent [
	^ parent
]

{ #category : #accessing }
LcsSystemManager >> parent: anObject [
	parent := anObject
]

{ #category : #accessing }
LcsSystemManager >> releaseEnvironment [
	self removeCurrentSystem
]

{ #category : #accessing }
LcsSystemManager >> removeCurrentSystem [
	LcsUnitOfWorkManager clearUnitOfWorkFor: self currentSystem.
	self currentSystem: nil.
]
