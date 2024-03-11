Class {
	#name : #LcsBaseUnitOfWork,
	#superclass : #LcsObject,
	#instVars : [
		'addedObjects',
		'changedObjects',
		'deletedObjects',
		'system',
		'unitOfWorkName'
	],
	#category : #'Lcs-UnitOfWOrk'
}

{ #category : #'instance creation' }
LcsBaseUnitOfWork class >> newOn: aSystem [ 
	^self new
		initializeOn: aSystem;
		yourself
]

{ #category : #api }
LcsBaseUnitOfWork >> addObject: aDomainObject [

	self addedObjects at: aDomainObject put: (LcsAddedObjectRecord newFor: aDomainObject parent: self)
]

{ #category : #api }
LcsBaseUnitOfWork >> addRecordFor: aDomainObject [
	^ self addedObjects at: aDomainObject
]

{ #category : #accessing }
LcsBaseUnitOfWork >> addedObjects [
	^ addedObjects
]

{ #category : #accessing }
LcsBaseUnitOfWork >> addedObjects: anObject [
	addedObjects := anObject
]

{ #category : #api }
LcsBaseUnitOfWork >> applyChanges [
	self addedObjects valuesDo: [ :each | each applyChanges ].
	self changedObjects do: [ :each | each applyChanges ]
]

{ #category : #accessing }
LcsBaseUnitOfWork >> changedObjects [
	^ changedObjects
]

{ #category : #accessing }
LcsBaseUnitOfWork >> changedObjects: anObject [
	changedObjects := anObject
]

{ #category : #api }
LcsBaseUnitOfWork >> changedRecordFor: aDomainObject [
	^ (self changedObjects at: aDomainObject ifAbsent: [ nil ])
]

{ #category : #api }
LcsBaseUnitOfWork >> changedSlot: aSlotName valueTo: anObject in: aDomainObject [

	(self addedObjects keys includes: aDomainObject) ifTrue: [ ^ self ].
	(self changedObjects at: anObject ifAbsentPut: [ LcsChangedObjectRecord newFor: aDomainObject parent: self ])
		changedSlot: aSlotName valueTo: anObject
		
]

{ #category : #initialization }
LcsBaseUnitOfWork >> clearUnitOfWork [
	self addedObjects: LcsSmalltalkConfiguration objectKeyDictionaryClass new.
	self changedObjects: LcsSmalltalkConfiguration objectKeyDictionaryClass new.
	self deletedObjects: LcsSmalltalkConfiguration objectKeyDictionaryClass new
]

{ #category : #api }
LcsBaseUnitOfWork >> deleteObject: aDomainObject [
	self deletedObjects at: aDomainObject put: (LcsDeletedObjectRecord newFor: aDomainObject parent: self)
]

{ #category : #accessing }
LcsBaseUnitOfWork >> deletedObjects [
	^ deletedObjects
]

{ #category : #accessing }
LcsBaseUnitOfWork >> deletedObjects: anObject [
	deletedObjects := anObject
]

{ #category : #initialization }
LcsBaseUnitOfWork >> initialize [
	super initialize.
	self clearUnitOfWork
]

{ #category : #initialization }
LcsBaseUnitOfWork >> initializeOn: aSystem [ 
	self system: aSystem
]

{ #category : #api }
LcsBaseUnitOfWork >> setValueTo: anObject in: aDomainObject forSlot: aSlotDefiniton [ 

	(self addedObjects keys includes: aDomainObject) ifTrue: [ 
		aDomainObject instVarNamed: aSlotDefiniton slotName asString put: anObject.
		^ self ].
	(self changedObjects at: aDomainObject ifAbsentPut: [ LcsChangedObjectRecord newFor: aDomainObject parent: self ])
		changedSlot: aSlotDefiniton slotName valueTo: anObject
		
]

{ #category : #accessing }
LcsBaseUnitOfWork >> system [
	^ system
]

{ #category : #accessing }
LcsBaseUnitOfWork >> system: aSystem [ 
	system := aSystem	
]

{ #category : #accessing }
LcsBaseUnitOfWork >> unitOfWorkName [
	^ unitOfWorkName
]

{ #category : #accessing }
LcsBaseUnitOfWork >> unitOfWorkName: anObject [
	unitOfWorkName := anObject
]
