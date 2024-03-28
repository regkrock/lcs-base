"
This is the base class for defining systems. A system class can have zero to many module components.
"
Class {
	#name : #LcsBaseSystem,
	#superclass : #LcsBaseModule,
	#instVars : [
		'slotModel'
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

{ #category : #system }
LcsBaseSystem class >> removeCurrentSystem [
	LcsApplicationEnvironment removeCurrentSystem
]

{ #category : #accessing }
LcsBaseSystem >> addToSlotModel: aSlotDefinitions [
	self slotModel addSlotDefinitions: aSlotDefinitions
]

{ #category : #'building - model' }
LcsBaseSystem >> buildSlotDefinitions [
	self domainClasses do: [ :eachDomainClass | eachDomainClass initializeSlotDefinitions ]
]

{ #category : #accessing }
LcsBaseSystem >> currentUnitOfWork [

	^ LcsApplicationEnvironment currentUnitOfWork
]

{ #category : #initialization }
LcsBaseSystem >> domainClasses [
	^ OrderedCollection new
]

{ #category : #accessing }
LcsBaseSystem >> hasSlotDefinitions [
	^ self slotModel hasSlotDefinitions
]

{ #category : #initialization }
LcsBaseSystem >> initialize [
	super initialize.
	self 
		slotModel: (LcsSlotModel newOn: self);
		buildSlotDefinitions;
		buildModules;
		initializeModel
]

{ #category : #accessing }
LcsBaseSystem >> initializeInUnitOfWork: aUnitOfWork [
	aUnitOfWork system: self.
	aUnitOfWork addObject: self. "Need to add to unit of work"
	self initialize.
	self currentUnitOfWork applyChanges.

]

{ #category : #accessing }
LcsBaseSystem >> relatedUnitOfWork [
	^ self parent unitsOfWorkManager unitOfWorkFor: self
]

{ #category : #accessing }
LcsBaseSystem >> remove [ 
	self parent removeSystem: self
]

{ #category : #accessing }
LcsBaseSystem >> restoreSlotModel [
	self slotModel restoreSlotModel
]

{ #category : #accessing }
LcsBaseSystem >> slotModel [
	^ slotModel
]

{ #category : #accessing }
LcsBaseSystem >> slotModel: anObject [
	slotModel := anObject
]
