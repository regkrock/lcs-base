Class {
	#name : #LcsSystem,
	#superclass : #LcsBaseModule,
	#instVars : [
		'currentUnitOfWork',
		'unitsOfWork'
	],
	#classVars : [
		'Singleton'
	],
	#category : #'Lcs-System'
}

{ #category : #accessing }
LcsSystem class >> basicSingleton [

	^Singleton
]

{ #category : #accessing }
LcsSystem class >> basicSingleton: anObject [

	Singleton := anObject
]

{ #category : #accessing }
LcsSystem class >> clearSingleton [
	self basicSingleton: nil
]

{ #category : #accessing }
LcsSystem class >> createNewSingleton [
	self basicSingleton: nil.
	self singleton
]

{ #category : #accessing }
LcsSystem class >> currentUnitOfWork [
	^self singleton currentUnitOfWork
]

{ #category : #accessing }
LcsSystem class >> singelton: anUndefinedObject [ 

	self basicSingleton: anUndefinedObject
]

{ #category : #accessing }
LcsSystem class >> singleton [

	^self basicSingleton ifNil: [
		self basicSingleton: LcsSystem new.
		self basicSingleton]
]

{ #category : #'unit of work' }
LcsSystem >> addNewUnitOfWork [

	| newUnitOfWork |
	
	newUnitOfWork := LcsUnitOfWork newOn: self.
	self assert: newUnitOfWork system == self.
	self unitsOfWork add: newUnitOfWork.
	self currentUnitOfWork: newUnitOfWork.
	^newUnitOfWork
]

{ #category : #accessing }
LcsSystem >> currentUnitOfWork [

	^currentUnitOfWork
]

{ #category : #accessing }
LcsSystem >> currentUnitOfWork: anObject [
	currentUnitOfWork := anObject
]

{ #category : #'initialize  ' }
LcsSystem >> initialize [
	super initialize.
	self unitsOfWork: OrderedCollection new.
	self addNewUnitOfWork.
	LcsDomainObject buildSlotDefinitions.
	self buildModules
]

{ #category : #'modules ' }
LcsSystem >> moduleClasses [
	^ OrderedCollection new
		add: #LcsGeographyModule asClass;
		yourself
]

{ #category : #accessing }
LcsSystem >> unitsOfWork [
	^ unitsOfWork
]

{ #category : #accessing }
LcsSystem >> unitsOfWork: anObject [
	unitsOfWork := anObject
]
