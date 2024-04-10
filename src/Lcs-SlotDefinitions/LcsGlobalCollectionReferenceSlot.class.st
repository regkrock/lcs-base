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

{ #category : #model }
LcsGlobalCollectionReferenceSlot >> globalCollectionSlotDefinition [
	^ self module slotDefinitionNamed: self collectionSlotName
]

{ #category : #accessing }
LcsGlobalCollectionReferenceSlot >> gtSlotDefinitionAttributes [
	^ super gtSlotDefinitionAttributes
		add: 'moduleName' -> self moduleName;
		add: 'collectionSlotName' -> self collectionSlotName;
		yourself
]

{ #category : #model }
LcsGlobalCollectionReferenceSlot >> initializeModel: aDomainObject [
	"The global collection is initialized by the module, not from the parent"
]

{ #category : #model }
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

{ #category : #model }
LcsGlobalCollectionReferenceSlot >> persistValue: aDomainObject [
	(self module slotDefinitionNamed: self collectionSlotName) persistValue: aDomainObject in: self module

]
