Class {
	#name : #LcsUnitsOfWorkManager,
	#superclass : #LcsApplicationObject,
	#traits : 'LtParentTrait',
	#classTraits : 'LtParentTrait classTrait',
	#instVars : [
		'currentUnitOfWork',
		'unitsOfWork'
	],
	#classInstVars : [
		'Singleton'
	],
	#category : #'Lcs-SystemManagement-Environment'
}

{ #category : #'instance creation' }
LcsUnitsOfWorkManager class >> new [
	"Use the #newOn: method"
	self shouldNotImplement

]

{ #category : #'instance creation' }
LcsUnitsOfWorkManager class >> newOn: anObject [
	^ self basicNew initialize
		initializeOn: anObject;
		yourself
]

{ #category : #'gt views' }
LcsUnitsOfWorkManager >> applicationEnvironmentViewChildren [
	^ {
		LcsApplicationEnvironmentViewItem newOn: self label: 'Current Unit Of Work' item: self currentUnitOfWork.
		LcsApplicationEnvironmentViewItem newOn: self label: 'Units Of Work' item: self unitsOfWork. }
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

{ #category : #api }
LcsUnitsOfWorkManager >> createUnitOfWorkForCurrentSystem [
	^ self createUnitOfWorkFor: self currentSystem
]

{ #category : #accessing }
LcsUnitsOfWorkManager >> currentUnitOfWork [
	^ currentUnitOfWork
]

{ #category : #accessing }
LcsUnitsOfWorkManager >> currentUnitOfWork: anObject [
	currentUnitOfWork := anObject
]

{ #category : #'gt views' }
LcsUnitsOfWorkManager >> gtUnitsOfWorkManagerFor: aView [
		<gtView>
	^ aView columnedList
		title: 'Units Of Work';
		priority: 10;
		items: [ { 
					'Current Unit Of Work' -> self currentUnitOfWork.
					'Current Systen' -> (self currentUnitOfWork ifNotNil: [ :obj | self currentUnitOfWork system ]).
					'Number Of Units Of Work' -> self numberOfUnitsOfWork.
					'Units Of Work' -> self unitsOfWork collection} ];
		column: 'Option' text: #key width: 200;
		column: 'Value' text: #value;
		send: #value;
		yourself
		
]

{ #category : #testing }
LcsUnitsOfWorkManager >> hasCurrentUnitOfWork [
	^self currentUnitOfWork notNil
]

{ #category : #testing }
LcsUnitsOfWorkManager >> hasUnitsOfWork [
	^ self unitsOfWork hasElements
]

{ #category : #initialize }
LcsUnitsOfWorkManager >> initialize [
	super initialize.
	self unitsOfWork: (LcsUnitsOfWork newOn: self)
]

{ #category : #query }
LcsUnitsOfWorkManager >> numberOfUnitsOfWork [
	^ self unitsOfWork collectionSize
]

{ #category : #release }
LcsUnitsOfWorkManager >> releaseApplicationEnvironment [
	self currentUnitOfWork: nil.
	self unitsOfWork removeAll
]

{ #category : #api }
LcsUnitsOfWorkManager >> removeAllUnitsOfWork [
	self removeCurrentUnitOfWork.
	self unitsOfWork removeAll
]

{ #category : #api }
LcsUnitsOfWorkManager >> removeCurrentUnitOfWork [
	self unitsOfWork remove: self currentUnitOfWork ifAbsent: [ nil ]. 
	self currentUnitOfWork: nil
]

{ #category : #api }
LcsUnitsOfWorkManager >> removeUnitsOfWorkFor: aSystem [
	self unitsOfWork removeUnitsOfWorkFor: aSystem.
	self currentUnitOfWork ifNil: [ ^ self ].	
	(self currentUnitOfWork isKindOf: LcsBaseUnitOfWork)
		ifFalse: [ 
			self removeCurrentUnitOfWork.
			^ self ].
	self currentUnitOfWork system == aSystem ifTrue: [ self removeCurrentUnitOfWork ]
]

{ #category : #api }
LcsUnitsOfWorkManager >> restoreUnitOfWorkFor: aSystem [
	self
		currentUnitOfWork: (aSystem ifNil: [  ] ifNotNil: [ self unitOfWorkFor: aSystem ])
]

{ #category : #api }
LcsUnitsOfWorkManager >> suspendUnitOfWorkFor: aSystem [
	self currentUnitOfWork: nil
]

{ #category : #api }
LcsUnitsOfWorkManager >> unitOfWorkFor: aSystem [
	^ self unitsOfWork unitOfWorkFor: aSystem
]

{ #category : #accessing }
LcsUnitsOfWorkManager >> unitsOfWork [
	^ unitsOfWork
]

{ #category : #accessing }
LcsUnitsOfWorkManager >> unitsOfWork: anObject [
	unitsOfWork := anObject
]
