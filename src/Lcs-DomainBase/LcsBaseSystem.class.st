"
This is the base class for defining systems. A system class can have zero to many module components.
"
Class {
	#name : #LcsBaseSystem,
	#superclass : #LcsBaseModule,
	#instVars : [
		'slotModel',
		'status'
	],
	#category : #'Lcs-DomainBase'
}

{ #category : #configuration }
LcsBaseSystem class >> moduleName [
	^ 'System'
]

{ #category : #'instance creation' }
LcsBaseSystem class >> new [
	"A factory pattern is used here. The creation of the system is delegated to the system manager"
	^ LcsApplicationEnvironment createCurrentSystemFor: self
]

{ #category : #'slot model' }
LcsBaseSystem >> addToSlotModel: aSlotDefinitions [
	self slotModel addSlotDefinitions: aSlotDefinitions
]

{ #category : #intialization }
LcsBaseSystem >> allModuleClasses [
	| moduleClasses |
	moduleClasses := OrderedCollection new.
	self class addModuleClassesTo: moduleClasses.
	^moduleClasses
]

{ #category : #'slot model' }
LcsBaseSystem >> buildSlotDefinitions [
	self systemDomainClasses do: [ :eachDomainClass | eachDomainClass initializeSlotModel ]
]

{ #category : #'unit of work' }
LcsBaseSystem >> currentUnitOfWork [
	^ self parent currentUnitOfWork
]

{ #category : #accessing }
LcsBaseSystem >> gtSlotModelFor: aView [
	<gtView>
	(self slotModel isNil or: [self slotModel hasSlotDefinitions not])
		ifTrue: [ ^ aView empty ].
	^ aView forward
		title: 'Slot Model';
		priority: 1;
		object: [ self slotModel ];
		view: #gtSlotModelFor:;
		yourself
]

{ #category : #testing }
LcsBaseSystem >> hasSlotDefinitions [
	^ self slotModel hasSlotDefinitions
]

{ #category : #initialization }
LcsBaseSystem >> initialize [
	super initialize.
	self 
		status: (LcsSystemActiveStatus newOn: self);
		slotModel: (LcsSlotModel newOn: self);
		buildSlotDefinitions;
		buildModules;
		initializeModel
]

{ #category : #initialization }
LcsBaseSystem >> initializeInUnitOfWork: aUnitOfWork [
	aUnitOfWork system: self.
	aUnitOfWork addObject: self. "Need to add to unit of work"
	self initialize.
	self currentUnitOfWork applyChanges.

]

{ #category : #accessing }
LcsBaseSystem >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPutAll: ' (';
		nextPutAll: self statusNameString;
		nextPutAll: ')'
]

{ #category : #asking }
LcsBaseSystem >> relatedUnitOfWork [
	^ self parent unitsOfWorkManager unitOfWorkFor: self
]

{ #category : #accessing }
LcsBaseSystem >> releaseSlotModel [
	self parent releaseSlotModel
]

{ #category : #remove }
LcsBaseSystem >> removeSystem [ 
	self parent removeSystem: self
]

{ #category : #restore }
LcsBaseSystem >> restoreSlotModel [
	self slotModel restoreSlotModel
]

{ #category : #restore }
LcsBaseSystem >> restoreSystem [
	self status restoreSystem
]

{ #category : #'restore\t' }
LcsBaseSystem >> restoreUnitOfWork [
	self parent restoreUnitOfWorkFor: self
]

{ #category : #accessing }
LcsBaseSystem >> slotModel [
	^ slotModel
]

{ #category : #accessing }
LcsBaseSystem >> slotModel: anObject [
	slotModel := anObject
]

{ #category : #accessing }
LcsBaseSystem >> status [
	^ status
]

{ #category : #initialization }
LcsBaseSystem >> status: aSystemStatus [ 
	status := aSystemStatus
]

{ #category : #accessing }
LcsBaseSystem >> statusNameString [
	^ self status ifNil: [ 'no status' ] ifNotNil: [ self status statusName ]
]

{ #category : #suspend }
LcsBaseSystem >> suspendSystem [
	self status suspendSystem
]

{ #category : #suspend }
LcsBaseSystem >> suspendUnitOfWork [
	self parent suspendUnitOfWorkFor: self
]

{ #category : #'slot model' }
LcsBaseSystem >> systemDomainClasses [
	^ OrderedCollection new
]
