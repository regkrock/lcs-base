Class {
	#name : #LcsGlobalCollectionReferenceSlotDefinition,
	#superclass : #LcsSlotDefinition,
	#instVars : [
		'moduleName',
		'collectionSlotName'
	],
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #accessing }
LcsGlobalCollectionReferenceSlotDefinition >> collectionSlotName [
	^ collectionSlotName
]

{ #category : #accessing }
LcsGlobalCollectionReferenceSlotDefinition >> collectionSlotName: anObject [
	collectionSlotName := anObject
]

{ #category : #model }
LcsGlobalCollectionReferenceSlotDefinition >> globalCollectionSlotDefinition [
	^ self module slotDefinitionNamed: self collectionSlotName
]

{ #category : #model }
LcsGlobalCollectionReferenceSlotDefinition >> initializeModel: aDomainObject [
	"The global collection is initialized by the module, not from the parent"
]

{ #category : #model }
LcsGlobalCollectionReferenceSlotDefinition >> module [
	^ self currentSystem moduleNamed: self moduleName
]

{ #category : #accessing }
LcsGlobalCollectionReferenceSlotDefinition >> moduleName [
	^ moduleName
]

{ #category : #accessing }
LcsGlobalCollectionReferenceSlotDefinition >> moduleName: aString [ 
	moduleName := aString
]

{ #category : #model }
LcsGlobalCollectionReferenceSlotDefinition >> persistValue: aDomainObject [
	(self module slotDefinitionNamed: self collectionSlotName) persistValue: aDomainObject in: self module

]
