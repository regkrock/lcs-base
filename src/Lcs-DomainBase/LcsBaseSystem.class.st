"
This is the base class for defining systems. A system class can have zero to many module components.
"
Class {
	#name : #LcsBaseSystem,
	#superclass : #LcsBaseModule,
	#instVars : [
		'currentUnitOfWork',
		'unitsOfWork',
		'slotModel'
	],
	#category : #'Lcs-DomainBase'
}

{ #category : #'unit of work' }
LcsBaseSystem class >> currentUnitOfWork [
	^ self currentSystem currentUnitOfWork
]

{ #category : #configuration }
LcsBaseSystem class >> moduleName [
	^ 'System'
]

{ #category : #'instance creation' }
LcsBaseSystem class >> newInUnitOfWorK: aUnitOfWork [ 
	self currentSystem: self basicNew.
	self currentSystem initializeInUnitOfWork: aUnitOfWork.
	^ self currentSystem

]

{ #category : #'instance creation' }
LcsBaseSystem class >> newSystem [
	LcsApplicationEnvironment hasInitializedEnvironment ifFalse: [ LcsApplicationEnivronmentNotInitializedError signal: 'Unable to create a system because application environment is not initialized' ].
	self removeCurrentSystem.
	self newInUnitOfWorK: LcsUnitOfWorkManager createUnitOfWork.
	^ self currentSystem
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

	^ LcsUnitOfWorkManager currentUnitOfWork
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
	aUnitOfWork system: self currentSystem.
	aUnitOfWork addObject: self currentSystem. "Need to add to unit of work"
	self currentSystem initialize.
	self currentSystem currentUnitOfWork applyChanges.

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

{ #category : #accessing }
LcsBaseSystem >> unitsOfWork [
	^ unitsOfWork
]

{ #category : #accessing }
LcsBaseSystem >> unitsOfWork: anObject [
	unitsOfWork := anObject
]
