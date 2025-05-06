Class {
	#name : #LcsBaseUnitOfWork,
	#superclass : #LcsApplicationObject,
	#traits : 'LtParentTrait',
	#classTraits : 'LtParentTrait classTrait',
	#instVars : [
		'addedObjects',
		'changedObjects',
		'deletedObjects',
		'system',
		'unitOfWorkName',
		'changedCollections'
	],
	#category : #'Lcs-SystemManagement-UnitOfWork'
}

{ #category : #api }
LcsBaseUnitOfWork >> _pendingAddsIn: aTargetCollection [
	^ (self collectionChagesFor: aTargetCollection)
		at: 'add'
]

{ #category : #api }
LcsBaseUnitOfWork >> _pendingDeletesIn: aTargetCollection [
	^ (self collectionChagesFor: aTargetCollection)
		at: 'delete'
]

{ #category : #api }
LcsBaseUnitOfWork >> addObject: aDomainObject [

	self addedObjects at: aDomainObject put: (LcsAddedObjectRecord newFor: aDomainObject parent: self).
	aDomainObject parentSlot setUpPendingAddOf: aDomainObject in: self
]

{ #category : #api }
LcsBaseUnitOfWork >> addObject: aDomainObject context: aDomainContextObject [
	aDomainObject isNil ifTrue: [ ^ self ].
	self addedObjects
		at: aDomainObject
		put: ((LcsAddedObjectRecord newFor: aDomainObject parent: self)
				creationContext: aDomainContextObject;
				yourself)
]

{ #category : #api }
LcsBaseUnitOfWork >> addObject: aDomainObject toCollection: aTargetCollection [

	self addedObjects at: aDomainObject put: (LcsAddedObjectRecord newFor: aDomainObject parent: self).
	aDomainObject parentSlot setUpPendingAddOf: aDomainObject in: self toCollection: aTargetCollection
]

{ #category : #private }
LcsBaseUnitOfWork >> addPendingAddOf: aDomainObject to: aTargetCollection [
	(self _pendingAddsIn: aTargetCollection) add: aDomainObject
]

{ #category : #private }
LcsBaseUnitOfWork >> addPendingDeletionOf: aDomainObject to: aTargetCollection [
	(self pendingDeletesIn: aTargetCollection) add: aDomainObject
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
LcsBaseUnitOfWork >> changedCollections [
	^ changedCollections
]

{ #category : #accessing }
LcsBaseUnitOfWork >> changedCollections: anObject [ 
	changedCollections := anObject
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

	self addedObjects removeAll.
	self changedObjects removeAll.
	self deletedObjects removeAll.
	self changedCollections removeAll.
]

{ #category : #private }
LcsBaseUnitOfWork >> collectionChagesFor: aTargetCollection [
	^ self changedCollections
		at: aTargetCollection
		ifAbsentPut: [ self newCollectionChaangesDictionary ]
]

{ #category : #api }
LcsBaseUnitOfWork >> deleteObject: aDomainObject [
	aDomainObject isNil ifTrue: [ ^ self ].
	self deletedObjects at: aDomainObject put: (LcsDeletedObjectRecord newFor: aDomainObject parent: self).
	aDomainObject parentSlot setUpPendingDeleteOf: aDomainObject in: self
]

{ #category : #accessing }
LcsBaseUnitOfWork >> deletedObjects [
	^ deletedObjects
]

{ #category : #accessing }
LcsBaseUnitOfWork >> deletedObjects: anObject [
	deletedObjects := anObject
]

{ #category : #'gt views' }
LcsBaseUnitOfWork >> gtUnitOfWorkChildren [
	^ {
		LcsUnitOfWorkViewItem newLabel: 'Added' item: self addedObjects values.
		LcsUnitOfWorkViewItem newLabel: 'Changed' item: self changedObjects values.
		LcsUnitOfWorkViewItem newLabel: 'Deleted' item: self deletedObjects values.
		}
]

{ #category : #'gt views' }
LcsBaseUnitOfWork >> gtUnitOfWorkFor: aView [
	<gtView>
	^ aView columnedTree 
		title: 'Live';
		priority: 2.5;
		expandUpTo: 1;
		items: [ self gtUnitOfWorkItems ];
		children: [ :each | each children ];
		column: 'Option'
			text: [ :each | each label ]
			width: 200;
		column: 'Value' text: [ :each | each gtItemDisplayString ];
		send: #item;
		actionUpdateButton;
		yourself
]

{ #category : #'gt views' }
LcsBaseUnitOfWork >> gtUnitOfWorkItems [
	^ {
		LcsUnitOfWorkViewItem newLabel: 'Unit Of Work' item: self.
		LcsUnitOfWorkViewItem newLabel: 'Added' item: self addedObjects values.
		LcsUnitOfWorkViewItem newLabel: 'Changed' item: self changedObjects values.
		LcsUnitOfWorkViewItem newLabel: 'Deleted' item: self deletedObjects values.
		}
]

{ #category : #testing }
LcsBaseUnitOfWork >> hasChangesForCollection: aTargetCollection [
	^ self changedCollections keys includes: aTargetCollection
]

{ #category : #private }
LcsBaseUnitOfWork >> hasCollectionChagesFor: aTargetCollection [
	^ (self changedCollections at: aTargetCollection ifAbsent: [ nil ])
		notNil
]

{ #category : #initialize }
LcsBaseUnitOfWork >> initialize [
	super initialize.
	self addedObjects: LcsSmalltalkConfiguration objectKeyDictionaryClass new.
	self changedObjects: LcsSmalltalkConfiguration objectKeyDictionaryClass new.
	self changedCollections: LcsSmalltalkConfiguration objectKeyDictionaryClass new.

	self deletedObjects: LcsSmalltalkConfiguration objectKeyDictionaryClass new.
	self clearUnitOfWork
]

{ #category : #private }
LcsBaseUnitOfWork >> newCollectionChaangesDictionary [
	^ Dictionary new
		at: 'add' put: OrderedCollection new;
		at: 'delete' put: OrderedCollection new;
		yourself
]

{ #category : #api }
LcsBaseUnitOfWork >> pendingAddsIn: aTargetCollection [
	(self hasChangesForCollection: aTargetCollection)
		ifFalse: [ ^ OrderedCollection new ].
	^ self _pendingAddsIn: aTargetCollection
]

{ #category : #api }
LcsBaseUnitOfWork >> pendingDeletesFromCollection: aTargetCollection [
	(self hasChangesForCollection: aTargetCollection)
		ifFalse: [ ^ OrderedCollection new ].
	^ self _pendingDeletesIn: aTargetCollection
]

{ #category : #api }
LcsBaseUnitOfWork >> pendingDeletesIn: aTargetCollection [
	(self changedCollections keys includes: aTargetCollection) ifFalse: [ ^OrderedCollection new ].
	^ (self collectionChagesFor: aTargetCollection) at: 'delete'
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
LcsBaseUnitOfWork >> setValueIn: aDomainObject slot: aSlotDefiniton to: anObject [ 

	(self addedObjects keys includes: aDomainObject) ifTrue: [ 
		"anObject isDomainObject ifTrue: [
			(anObject instVarNamed: 'parent') ifNil: [ anObject instVarNamed: 'parent' put: aDomainObject ] ]."
		aDomainObject instVarNamed: aSlotDefiniton slotName asString put: anObject.
		^ self ].
	(self changedObjects at: aDomainObject ifAbsentPut: [ LcsChangedObjectRecord newFor: aDomainObject parent: self ])
		changedSlot: aSlotDefiniton slotName valueTo: anObject
		
]

{ #category : #accessing }
LcsBaseUnitOfWork >> system [
	^ self parent
]

{ #category : #accessing }
LcsBaseUnitOfWork >> system: aSystem [ 
	self parent: aSystem	
]

{ #category : #accessing }
LcsBaseUnitOfWork >> unitOfWorkName [
	^ unitOfWorkName
]

{ #category : #accessing }
LcsBaseUnitOfWork >> unitOfWorkName: anObject [
	unitOfWorkName := anObject
]
