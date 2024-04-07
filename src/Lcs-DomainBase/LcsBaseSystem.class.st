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

{ #category : #'testing ' }
LcsBaseSystem class >> isApplicationSystemClass [
	^ true
]

{ #category : #configuration }
LcsBaseSystem class >> moduleName [
	^ 'System'
]

{ #category : #'instance creation' }
LcsBaseSystem class >> new [
	"A factory pattern is used here. The creation of the system is delegated to the system manager"
	^ LcsApplicationEnvironment createCurrentSystemFor: self
]

{ #category : #accessing }
LcsBaseSystem >> _restoreSystem [
	self suspendCurrentSystem.
	self
		restoreUnitOfWork;
		restoreSlotModel;
		status: (LcsSystemActiveStatus newOn: self).
	self systemManager currentSystem: self
]

{ #category : #accessing }
LcsBaseSystem >> _suspendSystem [ 
	self 
		releaseSlotModel;
		suspendUnitOfWork;
		status: (LcsSystemSuspendedStatus newOn: self ).
	self systemManager currentSystem: nil
]

{ #category : #'slot model' }
LcsBaseSystem >> addToSlotModel: aSlotDefinitions [
	self slotModel addSlotDefinitions: aSlotDefinitions
]

{ #category : #initialize }
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

{ #category : #'slot model' }
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

{ #category : #initialize }
LcsBaseSystem >> initialize [
	super initialize.
	self 
		status: (LcsSystemActiveStatus newOn: self);
		slotModel: (LcsSlotModel newOn: self);
		buildSlotDefinitions;
		buildModules;
		initializeModel
]

{ #category : #initialize }
LcsBaseSystem >> initializeInUnitOfWork: aUnitOfWork [
	aUnitOfWork system: self.
	aUnitOfWork addObject: self. "Need to add to unit of work"
	self initialize.
	self currentUnitOfWork applyChanges.

]

{ #category : #'testing\t' }
LcsBaseSystem >> isApplicationSystem [
	^ true
]

{ #category : #printing }
LcsBaseSystem >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPutAll: ' (';
		nextPutAll: self statusNameString;
		nextPutAll: ')'
]

{ #category : #'unit of work' }
LcsBaseSystem >> relatedUnitOfWork [
	^ self parent unitsOfWorkManager unitOfWorkFor: self
]

{ #category : #'slot model' }
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

{ #category : #restore }
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

{ #category : #accessing }
LcsBaseSystem >> status: aSystemStatus [ 
	status := aSystemStatus
]

{ #category : #printing }
LcsBaseSystem >> statusNameString [
	^ self status ifNil: [ 'no status' ] ifNotNil: [ self status statusName ]
]

{ #category : #accessing }
LcsBaseSystem >> suspendCurrentSystem [
	self systemManager suspendCurrentSystem
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

{ #category : #accessing }
LcsBaseSystem >> systemManager [
	^ self parent
]

{ #category : #accessing }
LcsBaseSystem >> toggleActionButtonLabel [
	^ self status toggleActionButtonLabel
]

{ #category : #accessing }
LcsBaseSystem >> toggleStatus [
	self status toggleStatus
]
