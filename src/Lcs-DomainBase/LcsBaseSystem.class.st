Class {
	#name : #LcsBaseSystem,
	#superclass : #LcsBaseModule,
	#instVars : [
		'currentUnitOfWork',
		'unitsOfWork'
	],
	#category : #'Lcs-DomainBase'
}

{ #category : #accessing }
LcsBaseSystem class >> clearCurrentSystem [
	self currentSystem: nil
]

{ #category : #accessing }
LcsBaseSystem class >> currentUnitOfWork [
	^self currentSystem currentUnitOfWork
]

{ #category : #accessing }
LcsBaseSystem class >> moduleName [
	^ 'System'
]

{ #category : #accessing }
LcsBaseSystem class >> newSystem [
	self clearCurrentSystem.
	self currentSystem: self basicNew.
	self currentSystem initialize.
	self currentSystem currentUnitOfWork applyChanges.
	^ self currentSystem
]

{ #category : #'unit of work' }
LcsBaseSystem >> addNewUnitOfWork [
	| newUnitOfWork |
	newUnitOfWork := LcsUnitOfWork newOn: self.
	self assert: newUnitOfWork system == self.
	self unitsOfWork add: newUnitOfWork.
	self currentUnitOfWork: newUnitOfWork.
	^ newUnitOfWork
]

{ #category : #'building - model' }
LcsBaseSystem >> buildSlotDefinitions [
	self domainClasses do: [ :eachDomainClass | eachDomainClass initializeSlotDefinitions ]
]

{ #category : #accessing }
LcsBaseSystem >> currentUnitOfWork [

	^ currentUnitOfWork
]

{ #category : #accessing }
LcsBaseSystem >> currentUnitOfWork: aUnitOfWork [ 
	currentUnitOfWork := aUnitOfWork
]

{ #category : #initialization }
LcsBaseSystem >> domainClasses [
	^ OrderedCollection new
]

{ #category : #initialization }
LcsBaseSystem >> initialize [
	super initialize.
	self 
		initializeUnitOfWork;
		buildSlotDefinitions;
		buildModules;
		initializeModel
]

{ #category : #initialization }
LcsBaseSystem >> initializeUnitOfWork [
	self unitsOfWork: OrderedCollection new.
	self addNewUnitOfWork
]

{ #category : #accessing }
LcsBaseSystem >> unitsOfWork [
	^ unitsOfWork
]

{ #category : #accessing }
LcsBaseSystem >> unitsOfWork: anObject [
	unitsOfWork := anObject
]