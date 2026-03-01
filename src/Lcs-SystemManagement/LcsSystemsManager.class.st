Class {
	#name : 'LcsSystemsManager',
	#superclass : 'LcsApplicationObject',
	#traits : 'LtParentTrait',
	#classTraits : 'LtParentTrait classTrait',
	#instVars : [
		'systems',
		'currentSystem'
	],
	#category : 'Lcs-SystemManagement-Environment',
	#package : 'Lcs-SystemManagement',
	#tag : 'Environment'
}

{ #category : 'instance creation' }
LcsSystemsManager class >> new [
	"Use the #newOn: method"
	self shouldNotImplement
]

{ #category : 'instance creation' }
LcsSystemsManager class >> newOn: anObject [
	^ self basicNew initialize;
		initializeOn: anObject;
		yourself
]

{ #category : 'api' }
LcsSystemsManager >> addCurrentSystem: aSystem [
	self suspendCurrentSystem.
	self currentSystem: aSystem.
	self addSystem: aSystem.
	aSystem unitOfWork: (self unitsOfWorkManager createCurrentUnitOfWorkFor: aSystem)
]

{ #category : 'api' }
LcsSystemsManager >> addSystem: aSystem [
	aSystem systemsManager: self.
	self systems add: aSystem
]

{ #category : 'query' }
LcsSystemsManager >> applicationEnvironment [
	^self parent applicationEnvironment
]

{ #category : 'gt views' }
LcsSystemsManager >> applicationEnvironmentViewChildren [
	^ {
		LcsApplicationEnvironmentViewItem newOn: self label: 'Current System' item: self currentSystem.
		LcsApplicationEnvironmentViewItem newOn: self label: 'Running Systems' item: self systems.
		LcsApplicationEnvironmentViewItem newOn: self label: 'Available Systems' item: '' "self availableSystemClasses". }
]

{ #category : 'gt views' }
LcsSystemsManager >> applicationEnvironmentViewaAvailableSystemsChildren [
	^ self availableSystemClasses
		collect: [ :eachClass | LcsApplicationEnvironmentViewItem newOn: self label: eachClass name item: eachClass ]
]

{ #category : 'api' }
LcsSystemsManager >> createCurrentSystemFor: aSystemClass [
	aSystemClass new.
	^ self currentSystem
]

{ #category : 'accessing' }
LcsSystemsManager >> currentSystem [
	^ currentSystem
]

{ #category : 'accessing' }
LcsSystemsManager >> currentSystem: anObject [
	currentSystem := anObject
]

{ #category : 'query' }
LcsSystemsManager >> currentUnitOfWork [
	^ self unitsOfWorkManager currentUnitOfWork
]

{ #category : 'api' }
LcsSystemsManager >> ensureCurrentSystemIs: aSystemClass [
	| suspendedSystem |
	self currentSystem class = aSystemClass ifTrue: [ ^ self currentSystem ].
	(suspendedSystem := self suspendedSystemFor: aSystemClass) 
		ifNil: [ aSystemClass new ]
		ifNotNil: [
			self currentSystem ifNotNil: [ self suspendCurrentSystem ].
			suspendedSystem restoreSystem ].
	^ self currentSystem
]

{ #category : 'gt views' }
LcsSystemsManager >> gtAllSystemsFor: aView [
	<gtView>
	^ aView columnedTree 
		title: 'Systems';
		priority: 2.5;
		expandUpTo: 3;
		items: [ {LcsApplicationEnvironmentViewItem newOn: self label: 'System Manager' item: self} ];
		children: [ :each | each children ];
		column: 'Option'
			text: [ :each | each label ]
			width: 200;
		column: 'Value' text: [ :each | each item displayString ];
		send: #item;
		yourself
]

{ #category : 'gt views' }
LcsSystemsManager >> gtSystemsManagerFor: aView [
		<gtView>
	^ aView columnedList
		title: 'System Manager';
		priority: 10;
		items: [ { 
					'Initialized' -> true.
					'Current System' -> self currentSystem .
					'Current Unit Of Work' -> self unitsOfWorkManager currentUnitOfWork.
					'Number Of Systems' -> self numberOfSystems.
					'Systems' -> self systems collection} ];
		column: 'Option' text: #key width: 200;
		column: 'Value' text: #value;
		send: #value;
		yourself
		
]

{ #category : 'testing' }
LcsSystemsManager >> hasCurrentSystem [
	^ self currentSystem notNil
]

{ #category : 'testing' }
LcsSystemsManager >> hasNoCurrentSystem [
	^ self currentSystem isNil
]

{ #category : 'testing' }
LcsSystemsManager >> hasNoSystems [
	^ self hasSystems not
]

{ #category : 'testing' }
LcsSystemsManager >> hasSystem: aSystem [
	^ self systems includes: aSystem
]

{ #category : 'testing' }
LcsSystemsManager >> hasSystems [
	^ self systems isNotEmpty
]

{ #category : 'initialize' }
LcsSystemsManager >> initialize [
	super initialize.
	self systems: (LcsSystems newOn: self)
]

{ #category : 'api' }
LcsSystemsManager >> makeSystemCurrent: aSystem [
	"self currentSystem: aSystem.
	self currentSystem 
		ifNil: [  self releaseSlotModel ]
		ifNotNil: [ self currentSystem restoreSystem ]"
	aSystem isNil ifTrue: [ ^ self ].
	aSystem restoreSystem
]

{ #category : 'query' }
LcsSystemsManager >> numberOfSystems [
	(self systems isKindOf: OrderedCollection) ifTrue: [ ^ self systems size ].
	^ self systems collectionSize
]

{ #category : 'private' }
LcsSystemsManager >> releaseApplicationEnvironment [
	self removeCurrentSystem.
	self systems removeAll
]

{ #category : 'api' }
LcsSystemsManager >> releaseSlotModel [
	LcsBaseDomainObject releaseSlotModel
]

{ #category : 'api' }
LcsSystemsManager >> removeCurrentSystem [
	self removeSystem: self currentSystem.
	self assert: self currentSystem isNil
]

{ #category : 'api' }
LcsSystemsManager >> removeCurrentSystemAndActivate: aSystem [
	(aSystem notNil and: [ self currentSystem ~~ aSystem ])
		ifTrue: [ self removeCurrentSystem.
			self assert: self currentSystem isNil.
			aSystem restoreSystem ].
	self assert: self currentSystem == aSystem
]

{ #category : 'api' }
LcsSystemsManager >> removeSystem: aSystem [
	aSystem isNil ifTrue: [ ^self ].
	self releaseSlotModel.
	self unitsOfWorkManager removeUnitsOfWorkFor: aSystem.
	self systems remove: aSystem ifAbsent: [ ].
	aSystem == self currentSystem ifTrue: [ self currentSystem: nil ]
]

{ #category : 'api' }
LcsSystemsManager >> restoreUnitOfWorkFor: suspendedSystem [
	^ self unitsOfWorkManager restoreUnitOfWorkFor: suspendedSystem
]

{ #category : 'api' }
LcsSystemsManager >> suspendCurrentSystem [
	| suspensionCandidate |
	suspensionCandidate := self currentSystem.
	suspensionCandidate ifNotNil: [ suspensionCandidate suspendSystem ].
	self currentSystem: nil.
	^ suspensionCandidate
]

{ #category : 'api' }
LcsSystemsManager >> suspendUnitOfWorkFor: suspendedSystem [
	^ self unitsOfWorkManager suspendUnitOfWorkFor: suspendedSystem
]

{ #category : 'api' }
LcsSystemsManager >> suspendedSystemFor: aSystemClass [
	^ self systems
		detect: [ :each | each class = aSystemClass ]
		ifNone: [ nil ]
]

{ #category : 'accessing' }
LcsSystemsManager >> systems [
	^ systems
]

{ #category : 'accessing' }
LcsSystemsManager >> systems: anObject [
	systems := anObject
]

{ #category : 'query' }
LcsSystemsManager >> unitsOfWorkManager [
	^ self parent unitsOfWorkManager
]
