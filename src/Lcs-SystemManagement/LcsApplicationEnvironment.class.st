Class {
	#name : #LcsApplicationEnvironment,
	#superclass : #LcsObject,
	#instVars : [
		'systemManager',
		'unitOfWorkManager'
	],
	#classInstVars : [
		'singleton'
	],
	#category : #'Lcs-SystemManagement'
}

{ #category : #accessing }
LcsApplicationEnvironment class >> clearCurrentUnitOfWork [
	self currentApplicationEnvironment ifNotNil: [ self currentApplicationEnvironment clearCurrentUnitOfWork ]
]

{ #category : #'instance creation' }
LcsApplicationEnvironment class >> createUnitOfWork [
	^ self currentApplicationEnvironment createUnitOfWork
]

{ #category : #accessing }
LcsApplicationEnvironment class >> currentApplicationEnvironment [
	^ self singleton
]

{ #category : #accessing }
LcsApplicationEnvironment class >> currentSystem [
	^ self currentApplicationEnvironment ifNil: [ nil ] ifNotNil: [ self currentApplicationEnvironment currentSystem] 
]

{ #category : #accessing }
LcsApplicationEnvironment class >> currentSystem: aSystem [ 
	self currentApplicationEnvironment ifNotNil: [ self currentApplicationEnvironment currentSystem: aSystem ]
]

{ #category : #accessing }
LcsApplicationEnvironment class >> currentUnitOfWork [
	^ self currentApplicationEnvironment ifNotNil: [ self currentApplicationEnvironment currentUnitOfWork ]
]

{ #category : #accessing }
LcsApplicationEnvironment class >> hasInitializedEnvironment [
	^ self currentApplicationEnvironment notNil
]

{ #category : #accessing }
LcsApplicationEnvironment class >> hasNoCurrentSystem [
	self currentApplicationEnvironment ifNil: [ ^ true ] ifNotNil: [ self currentApplicationEnvironment currentSystem isNil ]
]

{ #category : #accessing }
LcsApplicationEnvironment class >> hasNoCurrentUnitOfWork [
	self currentApplicationEnvironment ifNil: [ ^ true ] ifNotNil: [ self currentApplicationEnvironment currentUnitOfWork isNil ]
]

{ #category : #accessing }
LcsApplicationEnvironment class >> hasNoninitializedEnvironment [
	^ self currentApplicationEnvironment isNil
]

{ #category : #initiailize }
LcsApplicationEnvironment class >> initializeEnvironment [
	self singleton notNil ifTrue: [self error: 'Environment is already initialized'].
	LcsSmalltalkConfiguration gsSystemClass abortTransaction.
	self singleton: self basicNew initialize.
	LcsSmalltalkConfiguration gsSystemClass commitTransaction.
]

{ #category : #accessing }
LcsApplicationEnvironment class >> makeCurrentSystem: aSystem [
	self currentApplicationEnvironment makeCurrentSystem: aSystem
]

{ #category : #'instace creation' }
LcsApplicationEnvironment class >> new [
	"Use#initializeEnvironment instead"
	self shouldNotImplement
]

{ #category : #release }
LcsApplicationEnvironment class >> releaseEnvironment [
	self currentApplicationEnvironment ifNotNil: [
		 self currentApplicationEnvironment releaseEnvironment.
		 self singleton: nil ].
	
]

{ #category : #accessing }
LcsApplicationEnvironment class >> removeCurrentSystem [
	self currentApplicationEnvironment ifNotNil: [ self currentApplicationEnvironment removeCurrentSystem ]
]

{ #category : #running }
LcsApplicationEnvironment class >> restoreSystem: aSystem [
	self currentApplicationEnvironment restoreSystem: aSystem 
]

{ #category : #accessing }
LcsApplicationEnvironment class >> singleton [
	^ singleton
]

{ #category : #accessing }
LcsApplicationEnvironment class >> singleton: anObject [
	singleton := anObject
]

{ #category : #accessing }
LcsApplicationEnvironment class >> unitOfWorkManager [
	^ self currentApplicationEnvironment unitOfWorkManager
]

{ #category : #accessing }
LcsApplicationEnvironment >> addNewSystem: aSystem [
	self systemManager addNewSystem: aSystem
]

{ #category : #accessing }
LcsApplicationEnvironment >> clearCurrentUnitOfWork [
	^ self unitOfWorkManager clearCurrentUnitOfWork
]

{ #category : #accessing }
LcsApplicationEnvironment >> createUnitOfWork [
	^ self unitOfWorkManager createUnitOfWork
]

{ #category : #accessing }
LcsApplicationEnvironment >> currentSystem [
	^ self systemManager currentSystem
]

{ #category : #accessing }
LcsApplicationEnvironment >> currentSystem: aSystem [
	^ self systemManager currentSystem: aSystem
]

{ #category : #accessing }
LcsApplicationEnvironment >> currentUnitOfWork [
	^ self unitOfWorkManager currentUnitOfWork
]

{ #category : #accessing }
LcsApplicationEnvironment >> initialize [
	super initialize.
	self systemManager: (LcsSystemManager newOn: self).
	self unitOfWorkManager: (LcsUnitOfWorkManager newOn: self).
]

{ #category : #accessing }
LcsApplicationEnvironment >> makeCurrentSystem: aSystem [
	self systemManager makeCurrentSystem: aSystem
]

{ #category : #accessing }
LcsApplicationEnvironment >> releaseEnvironment [
	self systemManager ifNotNil: [ :manager | manager releaseEnvironment ].
	self unitOfWorkManager ifNotNil: [:manager | manager releaseEnvironment ].
	#LcsDomainObject asClass releaseEnvironment
]

{ #category : #accessing }
LcsApplicationEnvironment >> removeCurrentSystem [
	^ self systemManager removeCurrentSystem
]

{ #category : #accessing }
LcsApplicationEnvironment >> systemManager [
	^ systemManager
]

{ #category : #accessing }
LcsApplicationEnvironment >> systemManager: anObject [
	systemManager := anObject
]

{ #category : #accessing }
LcsApplicationEnvironment >> unitOfWorkManager [
	^ unitOfWorkManager
]

{ #category : #accessing }
LcsApplicationEnvironment >> unitOfWorkManager: anObject [
	unitOfWorkManager := anObject
]
