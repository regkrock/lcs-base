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

{ #category : #'unit of work' }
LcsBaseSystem class >> currentUnitOfWork [
	^ self parent currentUnitOfWork
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

{ #category : #'slot model' }
LcsBaseSystem >> addToSlotModel: aSlotDefinitions [
	self slotModel addSlotDefinitions: aSlotDefinitions
]

{ #category : #'slot model' }
LcsBaseSystem >> buildSlotDefinitions [
	self systemDomainClasses do: [ :eachDomainClass | eachDomainClass initializeSlotModel ]
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
