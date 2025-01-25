Class {
	#name : #LcsSystemsManager,
	#superclass : #LcsApplicationObject,
	#instVars : [
		'parent',
		'systems',
		'currentSystem'
	],
	#category : #'Lcs-SystemManagement-Environment'
}

{ #category : #'instance creation' }
LcsSystemsManager class >> new [
	"Use the #newOn: method"
	self shouldNotImplement
]

{ #category : #'instance creation' }
LcsSystemsManager class >> newOn: anAppicaltionEnvironment [
	^ self basicNew 
		initialize;
		initializeOn: anAppicaltionEnvironment;
		yourself
]

{ #category : #api }
LcsSystemsManager >> addSystem: aBasicSystem [
	self suspendCurrentSystem.
	self currentSystem: aBasicSystem.
	self currentSystem systemManager: self.
	self systems add: self currentSystem.
	self unitsOfWorkManager createUnitOfWorkForCurrentSystem. 
	"self currentUnitOfWork addObject: aBasicSystem"
]

{ #category : #querry }
LcsSystemsManager >> applicationEnvironment [
	^self parent applicationEnvironment
]

{ #category : #'gt view' }
LcsSystemsManager >> applicationEnvironmentViewChildren [
	^ {
		LcsApplicationEnvironmentViewItem newOn: self label: 'Current System' item: self currentSystem.
		LcsApplicationEnvironmentViewItem newOn: self label: 'Running Systems' item: self systems.
		LcsApplicationEnvironmentViewItem newOn: self label: 'Available Systems' item: '' "self availableSystemClasses". }
]

{ #category : #'gt view' }
LcsSystemsManager >> applicationEnvironmentViewaAvailableSystemsChildren [
	^ self availableSystemClasses
		collect: [ :eachClass | LcsApplicationEnvironmentViewItem newOn: self label: eachClass name item: eachClass ]
]

{ #category : #api }
LcsSystemsManager >> createCurrentSystemFor: aSystemClass [
	aSystemClass new.
	^ self currentSystem
]

{ #category : #accessing }
LcsSystemsManager >> currentSystem [
	^ currentSystem
]

{ #category : #accessing }
LcsSystemsManager >> currentSystem: anObject [
	currentSystem := anObject
]

{ #category : #querry }
LcsSystemsManager >> currentUnitOfWork [
	^ self unitsOfWorkManager currentUnitOfWork
]

{ #category : #'gt view' }
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

{ #category : #'gt view' }
LcsSystemsManager >> gtSystemManagerFor: aView [
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

{ #category : #testing }
LcsSystemsManager >> hasCurrentSystem [
	^ self currentSystem notNil
]

{ #category : #testing }
LcsSystemsManager >> hasNoCurrentSystem [
	^ self currentSystem isNil
]

{ #category : #testing }
LcsSystemsManager >> hasNoSystems [
	^ self hasSystems not
]

{ #category : #testing }
LcsSystemsManager >> hasSystems [
	^ self systems notEmpty
]

{ #category : #initialize }
LcsSystemsManager >> initialize [
	super initialize.
	self systems: (LcsSystems newOn: self)
]

{ #category : #initialize }
LcsSystemsManager >> initializeOn: anAppicaltionEnvironment [ 
	self parent: anAppicaltionEnvironment 
]

{ #category : #api }
LcsSystemsManager >> makeSystemCurrent: aSystem [
	"self currentSystem: aSystem.
	self currentSystem 
		ifNil: [  self releaseSlotModel ]
		ifNotNil: [ self currentSystem restoreSystem ]"
	aSystem isNil ifTrue: [ ^ self ].
	aSystem restoreSystem
]

{ #category : #querry }
LcsSystemsManager >> numberOfSystems [
	^ self systems size
]

{ #category : #accessing }
LcsSystemsManager >> parent [
	^ parent
]

{ #category : #accessing }
LcsSystemsManager >> parent: anObject [
	parent := anObject
]

{ #category : #private }
LcsSystemsManager >> releaseApplicationEnvironment [
	self removeCurrentSystem.
	self systems: OrderedCollection new
]

{ #category : #api }
LcsSystemsManager >> releaseSlotModel [
	LcsDomainObject releaseSlotModel
]

{ #category : #api }
LcsSystemsManager >> removeCurrentSystem [
	self removeSystem: self currentSystem
]

{ #category : #api }
LcsSystemsManager >> removeSystem: aSystem [
	aSystem isNil ifTrue: [ ^self ].
	self releaseSlotModel.
	self unitsOfWorkManager removeUnitsOfWorkFor: aSystem.
	self systems remove: aSystem ifAbsent: [ ].
	aSystem == self currentSystem ifTrue: [ self currentSystem: nil ]
]

{ #category : #api }
LcsSystemsManager >> restoreUnitOfWorkFor: suspendedSystem [
	^ self unitsOfWorkManager restoreUnitOfWorkFor: suspendedSystem
]

{ #category : #api }
LcsSystemsManager >> suspendCurrentSystem [
	| suspensionCandidate |
	suspensionCandidate := self currentSystem.
	suspensionCandidate ifNotNil: [ suspensionCandidate suspendSystem ].
	self currentSystem: nil.
	^ suspensionCandidate
]

{ #category : #api }
LcsSystemsManager >> suspendUnitOfWorkFor: suspendedSystem [
	^ self unitsOfWorkManager suspendUnitOfWorkFor: suspendedSystem
]

{ #category : #accessing }
LcsSystemsManager >> systems [
	^ systems
]

{ #category : #accessing }
LcsSystemsManager >> systems: anObject [
	systems := anObject
]

{ #category : #querry }
LcsSystemsManager >> unitsOfWorkManager [
	^ self parent unitsOfWorkManager
]
