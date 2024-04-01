Class {
	#name : #LcsUnitsOfWorkManager,
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
LcsUnitsOfWorkManager class >> new [
	"Use the #newOn: method"
	self shouldNotImplement

]

{ #category : #accessing }
LcsUnitsOfWorkManager class >> newOn: anApplicationEnvironment [
	^ self basicNew initialize
		initializeOn: anApplicationEnvironment;
		yourself
]

{ #category : #api }
LcsUnitsOfWorkManager >> createUnitOfWork [
	^ self createUnitOfWorkFor: nil
]

{ #category : #api }
LcsUnitsOfWorkManager >> createUnitOfWorkFor: aSystem [
	self currentUnitOfWork: (LcsUnitOfWork newOn: aSystem).
	self unitsOfWork add: self currentUnitOfWork.
	^ self currentUnitOfWork
]

{ #category : #accessing }
LcsUnitsOfWorkManager >> currentUnitOfWork [
	^ currentUnitOfWork
]

{ #category : #accessing }
LcsUnitsOfWorkManager >> currentUnitOfWork: anObject [
	currentUnitOfWork := anObject
]

{ #category : #testing }
LcsUnitsOfWorkManager >> hasCurrentUnitOfWork [
	^self currentUnitOfWork notNil
]

{ #category : #initialize }
LcsUnitsOfWorkManager >> initialize [
	super initialize.
	self unitsOfWork: OrderedCollection new
]

{ #category : #accessing }
LcsUnitsOfWorkManager >> initializeOn: anApplicationEnvironment [ 
	self parent: anApplicationEnvironment
]

{ #category : #accessing }
LcsUnitsOfWorkManager >> numberOfUnitsOfWork [
	^ self unitsOfWork size
]

{ #category : #accessing }
LcsUnitsOfWorkManager >> parent [
	^ parent
]

{ #category : #accessing }
LcsUnitsOfWorkManager >> parent: anApplicationEnvironment [ 
	parent := anApplicationEnvironment
]

{ #category : #'release ' }
LcsUnitsOfWorkManager >> releaseApplicationEnvironment [
	self currentUnitOfWork: nil.
	self unitsOfWork: OrderedCollection new
]

{ #category : #accessing }
LcsUnitsOfWorkManager >> removeAllUnitsOfWork [
	self removeCurrentUnitOfWork.
	self unitsOfWork: OrderedCollection new
]

{ #category : #api }
LcsUnitsOfWorkManager >> removeCurrentUnitOfWork [
	self unitsOfWork remove: self currentUnitOfWork ifAbsent: [ nil ]. 
	self currentUnitOfWork: nil
]

{ #category : #api }
LcsUnitsOfWorkManager >> removeUnitsOfWorkFor: aSystem [
	self unitsOfWork copy
		do: [ :each | each system == aSystem ifTrue: [ self unitsOfWork remove: each ] ].

	self currentUnitOfWork ifNil: [ ^ self ].	
	(self currentUnitOfWork isKindOf: LcsBaseUnitOfWork)
		ifFalse: [ 
			self removeCurrentUnitOfWork.
			^ self ].
	self currentUnitOfWork system == aSystem ifTrue: [ self removeCurrentUnitOfWork ]
]

{ #category : #accessing }
LcsUnitsOfWorkManager >> restoreUnitOfWorkFor: aSystem [
	self
		currentUnitOfWork: (aSystem ifNil: [  ] ifNotNil: [ self unitOfWorkFor: aSystem ])
]

{ #category : #api }
LcsUnitsOfWorkManager >> suspendUnitOfWorkFor: aSystem [
	self currentUnitOfWork: nil
]

{ #category : #accessing }
LcsUnitsOfWorkManager >> unitOfWorkFor: aSystem [
	^ self unitsOfWork
		detect: [ :each | each system == aSystem ]
		ifNone: [ LcsSystemHasNoUnitOfWorkError
				signal: 'No unit of work found for requested system' ]
]

{ #category : #accessing }
LcsUnitsOfWorkManager >> unitsOfWork [
	^ unitsOfWork
]

{ #category : #accessing }
LcsUnitsOfWorkManager >> unitsOfWork: anObject [
	unitsOfWork := anObject
]
