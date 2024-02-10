Class {
	#name : #LcsUnitOfWork,
	#superclass : #LcsObject,
	#instVars : [
		'addedObjects',
		'changedObjects',
		'deletedObjects',
		'system'
	],
	#category : #'Lcs-System'
}

{ #category : #'instance c' }
LcsUnitOfWork class >> newOn: aSystem [ 
	^self new
		initializeOn: aSystem;
		yourself
]

{ #category : #accessing }
LcsUnitOfWork >> addObject: aDomainObject [

	self addedObjects at: aDomainObject put: (LcsAddedObjectRecord newFor: aDomainObject parent: self)
]

{ #category : #accessing }
LcsUnitOfWork >> addedObjects [
	^ addedObjects
]

{ #category : #accessing }
LcsUnitOfWork >> addedObjects: anObject [
	addedObjects := anObject
]

{ #category : #accessing }
LcsUnitOfWork >> changedObjects [
	^ changedObjects
]

{ #category : #accessing }
LcsUnitOfWork >> changedObjects: anObject [
	changedObjects := anObject
]

{ #category : #api }
LcsUnitOfWork >> changedSlot: aSlotName valueTo: anObject in: aDomainObject [

	(self addedObjects keys includes: aDomainObject) ifTrue: [^self].
	(self changedObjects at: anObject ifAbsentPut: [LcsChangedObjectRecord newFor: aDomainObject parent: self])
		changedSlot: aSlotName valueTo: anObject
		
]

{ #category : #api }
LcsUnitOfWork >> deleteObject: aDomainObject [
	self deletedObjects at: aDomainObject put: (LcsDeletedObjectRecord newFor: aDomainObject parent: self)
]

{ #category : #accessing }
LcsUnitOfWork >> deletedObjects [
	^ deletedObjects
]

{ #category : #accessing }
LcsUnitOfWork >> deletedObjects: anObject [
	deletedObjects := anObject
]

{ #category : #accessing }
LcsUnitOfWork >> initialize [
	super initialize.
	self addedObjects: LcsSmalltalkConfiguration dictionaryClass new.
	self changedObjects: LcsSmalltalkConfiguration dictionaryClass new.
	self deletedObjects: LcsSmalltalkConfiguration dictionaryClass new.
]

{ #category : #accessing }
LcsUnitOfWork >> initializeOn: aSystem [ 
	self system: aSystem
]

{ #category : #accessing }
LcsUnitOfWork >> system [
	^ system
]

{ #category : #accessing }
LcsUnitOfWork >> system: aSystem [ 
	system := aSystem	
]

{ #category : #accessing }
LcsUnitOfWork >> valueOf: aSlotName in: aDomainObject [

	(self addedObjects keys includes: aDomainObject) ifTrue: [].
	 (self deletedObjects keys includes: aDomainObject) ifTrue: [].
	 (self changedObjects keys includes: aDomainObject) ifTrue: [].
]
