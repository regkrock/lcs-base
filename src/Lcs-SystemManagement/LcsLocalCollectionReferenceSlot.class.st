Class {
	#name : #LcsLocalCollectionReferenceSlot,
	#superclass : #LcsDomainObjectSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #'slot model' }
LcsLocalCollectionReferenceSlot >> collectionSlot [
	^ self collectionSlotModule slotDefinitionNamed: self collectionSlotName
]

{ #category : #'slot model' }
LcsLocalCollectionReferenceSlot >> collectionSlotModule [
	^ self currentSystem moduleNamed: self collectionSlotModuleName
]

{ #category : #properties }
LcsLocalCollectionReferenceSlot >> collectionSlotModuleName [
	^ self propertyAt: 'collectionSlotModuleName' ifAbsent: [ ]
]

{ #category : #properties }
LcsLocalCollectionReferenceSlot >> collectionSlotModuleName: aString [
	self propertyAt: 'collectionSlotModuleName' put: aString
]

{ #category : #properties }
LcsLocalCollectionReferenceSlot >> collectionSlotName [
	^ self propertyAt: 'collectionSlotName' ifAbsent: [ ]
]

{ #category : #properties }
LcsLocalCollectionReferenceSlot >> collectionSlotName: anObject [
	self propertyAt: 'collectionSlotName' put: anObject
]

{ #category : #'gt views' }
LcsLocalCollectionReferenceSlot >> gtSlotDefinitionAttributes [
	^ super gtSlotDefinitionAttributes
		add: 'collectionSlotModuleName' -> self collectionSlotModuleName;
		add: 'collectionSlotName' -> self collectionSlotName;
		yourself
]

{ #category : #'slot model' }
LcsLocalCollectionReferenceSlot >> initializeSlotValueIn: aDomainObject [
	"The parent is set when the object is created and added to the pending collection"
	
]

{ #category : #testing }
LcsLocalCollectionReferenceSlot >> isGlobalCollectionRefenceSlot [
	^ false
]

{ #category : #testing }
LcsLocalCollectionReferenceSlot >> isGlobalCollectionRefenceSlotTo: aSlotName [
	^ self isGlobalCollectionRefenceSlot and: [
	self collectionSlotName = aSlotName ]
]

{ #category : #'slot model' }
LcsLocalCollectionReferenceSlot >> moduleNamed: aModuleName [
	^ self currentSystem moduleNamed: aModuleName
]

{ #category : #'slot model' }
LcsLocalCollectionReferenceSlot >> persistValue: aDomainObject contextObject: aContextDomainObject [
	aDomainObject instVarNamed: self slotName put: self targetCollection.
	self collectionSlot persistValue: aDomainObject in: self collectionSlotModule
]

{ #category : #'unit of work' }
LcsLocalCollectionReferenceSlot >> setUpPendingAddOf: aDomainObject in: aUnitOfWork [

	"This supports an object being created without being added to a collection. 
	 If this option is chosen, the developer is reponsible to add it to the appropriate
	 collection's pending collection"

	"aUnitOfWork addPendingAddOf: aDomainObject to: self targetCollection "
]

{ #category : #'unit of work' }
LcsLocalCollectionReferenceSlot >> setUpPendingAddOf: aDomainObject in: aUnitOfWork toCollection: aCollection [
	aDomainObject parent: aCollection.
	aUnitOfWork addPendingAddOf: aDomainObject to: aCollection 
]

{ #category : #'unit of work' }
LcsLocalCollectionReferenceSlot >> setUpPendingDeleteOf: aDomainObject in: aUnitOfWork [

	aUnitOfWork addPendingAddOf: aDomainObject to: 
	self targetCollection 
]

{ #category : #private }
LcsLocalCollectionReferenceSlot >> targetCollection [
	^self collectionSlotModule perform: self collectionSlotName asSymbol
]
