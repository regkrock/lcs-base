Class {
	#name : #LcsUnitOfWorkManager,
	#superclass : #LcsObject,
	#instVars : [
		'currentUnitOfWork',
		'unitsOfWork',
		'parent'
	],
	#classInstVars : [
		'Singleton'
	],
	#category : #'Lcs-SystemManagement'
}

{ #category : #accessing }
LcsUnitOfWorkManager class >> clearAllUnitsOfWork [
	(self singleton ifNil: [ ^ self ]) clearAllUnitsOfWork
]

{ #category : #accessing }
LcsUnitOfWorkManager class >> clearCurrentUnitOfWork [
	LcsApplicationEnvironment clearCurrentUnitOfWork
]

{ #category : #accessing }
LcsUnitOfWorkManager class >> clearUnitOfWorKFor: aSystem [ 
	self singleton clearUnitOfWorKFor: aSystem 
]

{ #category : #accessing }
LcsUnitOfWorkManager class >> clearUnitOfWorkFor: aSystem [
	(self singleton ifNil: [ ^ self ])  clearUnitOfWorkFor: aSystem
]

{ #category : #api }
LcsUnitOfWorkManager class >> createUnitOfWork [
	^ LcsApplicationEnvironment createUnitOfWork
]

{ #category : #api }
LcsUnitOfWorkManager class >> createUnitOfWorkFor: aSystem [
	self singleton createUnitOfWorkFor: aSystem
]

{ #category : #accessing }
LcsUnitOfWorkManager class >> currentUnitOfWork [
	^ LcsApplicationEnvironment currentUnitOfWork
]

{ #category : #accessing }
LcsUnitOfWorkManager class >> hasCurrentUnitOfWork [
	^ LcsApplicationEnvironment  hasCurrentUnitOfWork
]

{ #category : #accessing }
LcsUnitOfWorkManager class >> hasNoCurrentUnitOfWork [
	^ self currentUnitOfWork isNil
]

{ #category : #accessing }
LcsUnitOfWorkManager class >> new [
	^LcsApplicationEnvironment unitOfWorkManager

]

{ #category : #accessing }
LcsUnitOfWorkManager class >> newOn: anApplicationEnvironment [
	^ self basicNew initialize
		initializeOn: anApplicationEnvironment;
		yourself
]

{ #category : #accessing }
LcsUnitOfWorkManager >> clearAllUnitsOfWork [
	self clearCurrentUnitOfWork.
	self unitsOfWork: OrderedCollection new
]

{ #category : #'api\t' }
LcsUnitOfWorkManager >> clearCurrentUnitOfWork [
	self unitsOfWork remove: self currentUnitOfWork ifAbsent: [ nil ]. 
	self currentUnitOfWork: nil
]

{ #category : #api }
LcsUnitOfWorkManager >> clearUnitOfWorkFor: aSystem [
	self unitsOfWork copy
		do: [ :each | each system == aSystem ifTrue: [ self unitsOfWork remove: each ] ].

	self currentUnitOfWork ifNil: [ ^ self 
].	self currentUnitOfWork system = aSystem ifTrue: [ self clearCurrentUnitOfWork ]
]

{ #category : #api }
LcsUnitOfWorkManager >> createUnitOfWork [
	^ self createUnitOfWorkFor: nil
]

{ #category : #api }
LcsUnitOfWorkManager >> createUnitOfWorkFor: aSystem [
	self currentUnitOfWork: (LcsUnitOfWork newOn: aSystem).
	self unitsOfWork add: self currentUnitOfWork.
	^ self currentUnitOfWork
]

{ #category : #accessing }
LcsUnitOfWorkManager >> currentUnitOfWork [
	^ currentUnitOfWork
]

{ #category : #accessing }
LcsUnitOfWorkManager >> currentUnitOfWork: anObject [
	currentUnitOfWork := anObject
]

{ #category : #testing }
LcsUnitOfWorkManager >> hasCurrentUnitOfWork [
	^self currentUnitOfWork notNil
]

{ #category : #initialize }
LcsUnitOfWorkManager >> initialize [
	super initialize.
	self unitsOfWork: OrderedCollection new
]

{ #category : #accessing }
LcsUnitOfWorkManager >> initializeOn: anApplicationEnvironment [ 
	self parent: anApplicationEnvironment
]

{ #category : #accessing }
LcsUnitOfWorkManager >> parent [
	^ parent
]

{ #category : #accessing }
LcsUnitOfWorkManager >> parent: anApplicationEnvironment [ 
	parent := anApplicationEnvironment
]

{ #category : #'release ' }
LcsUnitOfWorkManager >> releaseEnvironment [
	self currentUnitOfWork: nil.
	self unitsOfWork: OrderedCollection new
]

{ #category : #accessing }
LcsUnitOfWorkManager >> unitsOfWork [
	^ unitsOfWork
]

{ #category : #accessing }
LcsUnitOfWorkManager >> unitsOfWork: anObject [
	unitsOfWork := anObject
]
