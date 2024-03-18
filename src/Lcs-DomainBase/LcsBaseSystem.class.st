Class {
	#name : #LcsBaseSystem,
	#superclass : #LcsBaseModule,
	#instVars : [
		'currentUnitOfWork',
		'unitsOfWork'
	],
	#category : #'Lcs-DomainBase'
}

{ #category : #system }
LcsBaseSystem class >> clearCurrentSystem [
	LcsSystemManager clearCurrentSystem
]

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
	self clearCurrentSystem.
	(self newInUnitOfWorK: LcsUnitOfWorkManager createUnitOfWork) .
	^ self currentSystem
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

{ #category : #initialization }
LcsBaseSystem >> initialize [
	super initialize.
	self 
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
LcsBaseSystem >> unitsOfWork [
	^ unitsOfWork
]

{ #category : #accessing }
LcsBaseSystem >> unitsOfWork: anObject [
	unitsOfWork := anObject
]
