Class {
	#name : #LcsGlobalCollectionReferenceSlot,
	#superclass : #LcsSlotDefintion,
	#instVars : [
		'moduleName',
		'collectionSlotName'
	],
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #accessing }
LcsGlobalCollectionReferenceSlot >> collectionSlotName [
	^ collectionSlotName
]

{ #category : #accessing }
LcsGlobalCollectionReferenceSlot >> collectionSlotName: anObject [
	collectionSlotName := anObject
]

{ #category : #'slot model' }
LcsGlobalCollectionReferenceSlot >> globalCollectionSlotDefinition [
	^ self module slotDefinitionNamed: self collectionSlotName
]

{ #category : #'gt view' }
LcsGlobalCollectionReferenceSlot >> gtSlotDefinitionAttributes [
	^ super gtSlotDefinitionAttributes
		add: 'moduleName' -> self moduleName;
		add: 'collectionSlotName' -> self collectionSlotName;
		yourself
]

{ #category : #'slot model' }
LcsGlobalCollectionReferenceSlot >> initializeSlotValueIn: aDomainObject [
	"The global collection is initialized by the module, not from the parent"
]

{ #category : #'slot model' }
LcsGlobalCollectionReferenceSlot >> module [
	^ self currentSystem moduleNamed: self moduleName
]

{ #category : #accessing }
LcsGlobalCollectionReferenceSlot >> moduleName [
	^ moduleName
]

{ #category : #accessing }
LcsGlobalCollectionReferenceSlot >> moduleName: aString [ 
	moduleName := aString
]

{ #category : #'slot model' }
LcsGlobalCollectionReferenceSlot >> persistValue: aDomainObject [
	(self module slotDefinitionNamed: self collectionSlotName)
		persistValue: (
			aDomainObject
				parent: (self module perform: self collectionSlotName asSymbol);
				yourself)
		in: self module
]
