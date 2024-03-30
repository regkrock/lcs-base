Class {
	#name : #LcsSystemManager,
	#superclass : #LcsObject,
	#instVars : [
		'parent',
		'systems',
		'currentSystem'
	],
	#category : #'Lcs-SystemManagement'
}

{ #category : #'instance creation' }
LcsSystemManager class >> new [
	"Use the #newOn: method"
	self shouldNotImplement
]

{ #category : #'instance creation' }
LcsSystemManager class >> newOn: anAppicaltionEnvironment [
	^ self basicNew 
		initialize;
		initializeOn: anAppicaltionEnvironment;
		yourself
]

{ #category : #accessing }
LcsSystemManager >> createCurrentSystemFor: aSystemClass [
	self suspendCurrentSystem.
	self currentSystem: (aSystemClass basicNew
							parent: self;
							yourself).
	self currentSystem initializeInUnitOfWork: self unitsOfWorkManager createUnitOfWork.
	self systems add: self currentSystem.
	^ self currentSystem
]

{ #category : #accessing }
LcsSystemManager >> currentSystem [
	^ currentSystem
]

{ #category : #accessing }
LcsSystemManager >> currentSystem: anObject [
	currentSystem := anObject
]

{ #category : #querry }
LcsSystemManager >> currentUnitOfWork [
	^ self unitsOfWorkManager currentUnitOfWork
]

{ #category : #'testing ' }
LcsSystemManager >> hasCurrentSystem [
	^ self currentSystem notNil
]

{ #category : #'testing ' }
LcsSystemManager >> hasNoCurrentSystem [
	^ self currentSystem isNil
]

{ #category : #initialize }
LcsSystemManager >> initialize [
	super initialize.
	self systems: OrderedCollection new
]

{ #category : #initialize }
LcsSystemManager >> initializeOn: anAppicaltionEnvironment [ 
	self parent: anAppicaltionEnvironment 
]

{ #category : #api }
LcsSystemManager >> makeSystemCurrent: aSystem [
	self currentSystem: aSystem.
	self unitsOfWorkManager makeSystemCurrent: aSystem.
	self currentSystem 
		ifNil: [ self releaseSlotModel] 
		ifNotNil: [ self currentSystem restoreSlotModel ]
]

{ #category : #querry }
LcsSystemManager >> numberOfSystems [
	^ self systems size
]

{ #category : #accessing }
LcsSystemManager >> parent [
	^ parent
]

{ #category : #accessing }
LcsSystemManager >> parent: anObject [
	parent := anObject
]

{ #category : #api }
LcsSystemManager >> releaseEnvironment [
	self removeCurrentSystem.
	self systems: OrderedCollection new
]

{ #category : #api }
LcsSystemManager >> releaseSlotModel [
	#LcsDomainObject asClass releaseSlotModel
]

{ #category : #api }
LcsSystemManager >> removeCurrentSystem [
	self removeSystem: self currentSystem
]

{ #category : #api }
LcsSystemManager >> removeSystem: aSystem [
	self parent unitsOfWorkManager removeUnitsOfWorkFor: aSystem.
	self systems remove: aSystem ifAbsent: [ ].
	aSystem == self currentSystem ifTrue: [ self currentSystem: nil ]
]

{ #category : #api }
LcsSystemManager >> suspendCurrentSystem [
	| suspendedSystem |
	suspendedSystem := self currentSystem.
	self unitsOfWorkManager suspendUnitOfWorkFor: self currentSystem.
	self currentSystem: nil.
	^ suspendedSystem
]

{ #category : #accessing }
LcsSystemManager >> systems [
	^ systems
]

{ #category : #accessing }
LcsSystemManager >> systems: anObject [
	systems := anObject
]

{ #category : #accessing }
LcsSystemManager >> unitsOfWorkManager [
	^ self parent unitsOfWorkManager
]
