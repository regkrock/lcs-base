Class {
	#name : #LcsApplicationEnvironment,
	#superclass : #LcsObject,
	#instVars : [
		'systemManager',
		'unitsOfWorkManager'
	],
	#classInstVars : [
		'singleton'
	],
	#category : #'Lcs-SystemManagement'
}

{ #category : #'instance creation' }
LcsApplicationEnvironment class >> createCurrentSystemFor: aSystemClass [ 
	self verifyApplicationEnvironment.
	^ self currentApplicationEnvironment createCurrentSystemFor: aSystemClass
	
]

{ #category : #'instance creation' }
LcsApplicationEnvironment class >> createUnitOfWork [
	^ self currentApplicationEnvironment ifNotNil: [self currentApplicationEnvironment createUnitOfWork]
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

{ #category : #running }
LcsApplicationEnvironment class >> ensureInitialized [
	self hasInitializedEnvironment ifFalse: [ self initializeEnvironment ].
]

{ #category : #accessing }
LcsApplicationEnvironment class >> enusreInitialized [
	
]

{ #category : #'testing ' }
LcsApplicationEnvironment class >> hasCurrentUnitOfWork [
	^ self currentApplicationEnvironment ifNil: [ false ] ifNotNil: [ self currentApplicationEnvironment hasCurrentUnitOfWork]
]

{ #category : #accessing }
LcsApplicationEnvironment class >> hasInitializedEnvironment [
	^ self currentApplicationEnvironment notNil
]

{ #category : #accessing }
LcsApplicationEnvironment class >> hasNoCurrentSystem [
	^ self currentApplicationEnvironment ifNil: [ true ] ifNotNil: [ self currentApplicationEnvironment currentSystem isNil ]
]

{ #category : #accessing }
LcsApplicationEnvironment class >> hasNoCurrentUnitOfWork [
	^ self currentApplicationEnvironment ifNil: [ true ] ifNotNil: [ self currentApplicationEnvironment currentUnitOfWork isNil ]
]

{ #category : #testing }
LcsApplicationEnvironment class >> hasNoninitializedEnvironment [
	^ self currentApplicationEnvironment isNil
]

{ #category : #accessing }
LcsApplicationEnvironment class >> hasSystemManager [
	^ self currentApplicationEnvironment ifNil: [ false ] ifNotNil: [ self currentApplicationEnvironment hasSystemManager ]
]

{ #category : #accessing }
LcsApplicationEnvironment class >> hasUnitsOfWorkManager [
	^ self currentApplicationEnvironment ifNil: [ false ] ifNotNil: [ self currentApplicationEnvironment hasUnitsOfWorkManager ]
]

{ #category : #initiailize }
LcsApplicationEnvironment class >> initializeEnvironment [
	self singleton notNil ifTrue: [self error: 'Environment is already initialized'].
	LcsSmalltalkConfiguration gsSystemClass abortTransaction.
	self singleton: self basicNew initialize.
	LcsSmalltalkConfiguration gsSystemClass commitTransaction.
	^ self currentApplicationEnvironment
]

{ #category : #accessing }
LcsApplicationEnvironment class >> makeSystemCurrent: aSystem [
	self currentApplicationEnvironment ifNotNil: [ self currentApplicationEnvironment makeSystemCurrent: aSystem ]
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

{ #category : #accessing }
LcsApplicationEnvironment class >> removeCurrentUnitOfWork [
	self currentApplicationEnvironment ifNotNil: [ self currentApplicationEnvironment removeCurrentUnitOfWork ]
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
LcsApplicationEnvironment class >> suspendCurrentSystem [
	^ self currentApplicationEnvironment ifNotNil: [ self currentApplicationEnvironment suspendCurrentSystem ]
]

{ #category : #accessing }
LcsApplicationEnvironment class >> systemManager [
	^ self currentApplicationEnvironment ifNotNil: [ self currentApplicationEnvironment systemManager ]
]

{ #category : #accessing }
LcsApplicationEnvironment class >> unitsOfWorkManager [
	^ self currentApplicationEnvironment unitsOfWorkManager
]

{ #category : #'instance creation' }
LcsApplicationEnvironment class >> verifyApplicationEnvironment [
	self hasInitializedEnvironment
		ifFalse: [ LcsApplicationEnivronmentNotInitializedError
				signal: 'Unable to create a system because application environment is not initialized' ]
]

{ #category : #accessing }
LcsApplicationEnvironment >> createCurrentSystemFor: aSystemClass [
	^ self systemManager createCurrentSystemFor: aSystemClass
]

{ #category : #accessing }
LcsApplicationEnvironment >> createUnitOfWork [
	^ self unitsOfWorkManager createUnitOfWork
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
	^ self unitsOfWorkManager currentUnitOfWork
]

{ #category : #testing }
LcsApplicationEnvironment >> hasCurrentUnitOfWork [
	^self unitsOfWorkManager hasCurrentUnitOfWork
]

{ #category : #testing }
LcsApplicationEnvironment >> hasNoCurrentUnitOfWork [
	^ self unitsOfWorkManager hasNoCurrentUnitOfWork
]

{ #category : #testing }
LcsApplicationEnvironment >> hasSystemManager [
	^ self systemManager notNil
]

{ #category : #testing }
LcsApplicationEnvironment >> hasUnitsOfWorkManager [
	^self unitsOfWorkManager notNil
]

{ #category : #accessing }
LcsApplicationEnvironment >> initialize [
	super initialize.
	self systemManager: (LcsSystemManager newOn: self).
	self unitsOfWorkManager: (LcsUnitsOfWorkManager newOn: self).
]

{ #category : #accessing }
LcsApplicationEnvironment >> makeSystemCurrent: aSystem [
	self systemManager makeSystemCurrent: aSystem
]

{ #category : #'release\t' }
LcsApplicationEnvironment >> releaseEnvironment [
	self systemManager ifNotNil: [ :manager | manager releaseEnvironment ].
	self unitsOfWorkManager ifNotNil: [:manager | manager releaseEnvironment ].
	#LcsDomainObject asClass releaseEnvironment
]

{ #category : #accessing }
LcsApplicationEnvironment >> removeCurrentSystem [
	^ self systemManager removeCurrentSystem
]

{ #category : #accessing }
LcsApplicationEnvironment >> removeCurrentUnitOfWork [
	^ self unitsOfWorkManager removeCurrentUnitOfWork
]

{ #category : #accessing }
LcsApplicationEnvironment >> suspendCurrentSystem [
	^ self systemManager suspendCurrentSystem
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
LcsApplicationEnvironment >> unitsOfWorkManager [
	^ unitsOfWorkManager
]

{ #category : #accessing }
LcsApplicationEnvironment >> unitsOfWorkManager: anObject [
	unitsOfWorkManager := anObject
]
