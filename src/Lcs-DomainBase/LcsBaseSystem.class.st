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
	^'System'
]

{ #category : #accessing }
LcsBaseSystem class >> newSystem [
	self clearCurrentSystem.
	self currentSystem: self basicNew.
	self currentSystem initializeUnitOfWork.
	self currentSystem initialize.
	self currentSystem initializeModel.
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
	^newUnitOfWork
]

{ #category : #'initialize  ' }
LcsBaseSystem >> buildSlotDefinitions [
	self domainClasses do: [ :eachDomainClass | eachDomainClass initializeSlotDefinitions ]
]

{ #category : #accessing }
LcsBaseSystem >> currentUnitOfWork [

	^currentUnitOfWork
]

{ #category : #'unit of work' }
LcsBaseSystem >> currentUnitOfWork: aUnitOfWork [ 
	currentUnitOfWork := aUnitOfWork
]

{ #category : #'initialize  ' }
LcsBaseSystem >> domainClasses [
	^OrderedCollection new
]

{ #category : #accessing }
LcsBaseSystem >> initialize [
	super initialize.
	self buildSlotDefinitions.
	self buildModules
]

{ #category : #accessing }
LcsBaseSystem >> initializeModel [
	self slotDefintions initializeModel: self
]

{ #category : #'initialize  ' }
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
