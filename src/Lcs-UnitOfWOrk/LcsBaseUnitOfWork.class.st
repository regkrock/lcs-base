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

{ #category : #initialize }
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

{ #category : #accessing }
LcsBaseUnitOfWork >> gtUnitOfWorkFor: aView [
	^ aView empty
	"	column: 'Current'
			text: [ :eachItem :eachIndex | (eachItem == self currentUnitOfWork) displayString asRopedText foreground: Color gray ]
			width: 45;
		column: 'Index'
			text: [ :eachItem :eachIndex | eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Unit Of Work Name'
			text: [ :eachItem :eachIndex | eachItem unitOfWorkName asString asRopedText foreground: Color gray ]
			width: 140;
		column: 'Added'
			text: [ :eachItem :eachIndex | eachItem addedObjects size printString asRopedText foreground: Color gray ]
			width: 45;
		column: 'Changed'
			text: [ :eachItem :eachIndex | eachItem changedObjects size printString asRopedText foreground: Color gray ]
			width: 45;
column: 'Deleted'
			text: [ :eachItem :eachIndex | eachItem deletedObjects size printString asRopedText foreground: Color gray ]
			width: 45"
]

{ #category : #initialize }
LcsBaseUnitOfWork >> initialize [
	super initialize.
	self clearUnitOfWork
]

{ #category : #initialize }
LcsBaseUnitOfWork >> initializeOn: aSystem [ 
	self system: aSystem
]

{ #category : #accessing }
LcsBaseUnitOfWork >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPutAll: ' (';
		nextPutAll: self system printString;
		nextPutAll: ')'
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
