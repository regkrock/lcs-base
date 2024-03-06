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

{ #category : #accessing }
LcsGlobalCollectionReferenceSlotDefinition >> globalCollectionSlotDefinition [
	^ self module slotDefinitionNamed: self collectionSlotName
]

{ #category : #accessing }
LcsGlobalCollectionReferenceSlotDefinition >> initializeModel: aDomainObject [
	"The global collection is initialized by the module, not from the parent"
]

{ #category : #accessing }
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

{ #category : #accessing }
LcsGlobalCollectionReferenceSlotDefinition >> persistValue: aDomainObject [
	(self module slotDefinitionNamed: self collectionSlotName) persistValue: aDomainObject in: self module

]
