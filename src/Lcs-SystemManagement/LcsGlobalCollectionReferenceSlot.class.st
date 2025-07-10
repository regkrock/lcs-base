Class {
	#name : #LcsGlobalCollectionReferenceSlot,
	#superclass : #LcsDomainObjectSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #'slot model' }
LcsGlobalCollectionReferenceSlot >> collectionSlot [
	^ self collectionSlotModule slotDefinitionNamed: self collectionSlotName
]

{ #category : #'slot model' }
LcsGlobalCollectionReferenceSlot >> collectionSlotModule [
	^ self currentSystem moduleNamed: self collectionSlotModuleName
]

{ #category : #properties }
LcsGlobalCollectionReferenceSlot >> collectionSlotModuleName [
	^ self propertyAt: 'collectionSlotModuleName' ifAbsent: [ ]
]

{ #category : #properties }
LcsGlobalCollectionReferenceSlot >> collectionSlotModuleName: aString [
	self propertyAt: 'collectionSlotModuleName' put: aString
]

{ #category : #accessing }
LcsGlobalCollectionReferenceSlot >> collectionSlotName [
	^ self propertyAt: 'collectionSlotName' ifAbsent: []
]

{ #category : #accessing }
LcsGlobalCollectionReferenceSlot >> collectionSlotName: anObject [
	self propertyAt: 'collectionSlotName' put: anObject
]

{ #category : #'gt views' }
LcsGlobalCollectionReferenceSlot >> gtSlotDefinitionAttributes [
	^ super gtSlotDefinitionAttributes
		add: 'collectionSlotModuleName' -> self collectionSlotModuleName;
		add: 'collectionSlotName' -> self collectionSlotName;
		yourself
]

{ #category : #'slot model' }
LcsGlobalCollectionReferenceSlot >> initializeSlotValueIn: aDomainObject [
	"The global collection is initialized by the module, not from the parent"
	| targetModule |
	targetModule := self moduleNamed: self collectionSlotModuleName. 
	aDomainObject parent: (targetModule perform: self collectionSlotName asSymbol)
]

{ #category : #testing }
LcsGlobalCollectionReferenceSlot >> isGlobalCollectionRefenceSlot [
	^ true
]

{ #category : #testing }
LcsGlobalCollectionReferenceSlot >> isGlobalCollectionRefenceSlotTo: aSlotName [
	^ self isGlobalCollectionRefenceSlot and: [
	self collectionSlotName = aSlotName ]
]

{ #category : #'slot model' }
LcsGlobalCollectionReferenceSlot >> moduleNamed: aModuleName [
	^ self currentSystem moduleNamed: aModuleName
]

{ #category : #'slot model' }
LcsGlobalCollectionReferenceSlot >> persistValue: aDomainObject contextObject: aContextDomainObject [
	aDomainObject instVarNamed: self slotName put: self targetCollection.
	self collectionSlot persistValue: aDomainObject in: self collectionSlotModule
]

{ #category : #'as yet unclassified' }
LcsGlobalCollectionReferenceSlot >> setUpPendingAddOf: aDomainObject in: aUnitOfWork [

	aUnitOfWork addPendingAddOf: aDomainObject to: self targetCollection
]

{ #category : #'as yet unclassified' }
LcsGlobalCollectionReferenceSlot >> setUpPendingDeleteOf: aDomainObject in: aUnitOfWork [

	aUnitOfWork addPendingAddOf: aDomainObject to: 
	self targetCollection 
]

{ #category : #accessing }
LcsGlobalCollectionReferenceSlot >> targetCollection [
	^self collectionSlotModule perform: self collectionSlotName asSymbol
]
