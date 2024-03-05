Class {
	#name : #LcsGlobalCollectonReferenceSlotDefinition,
	#superclass : #LcsSlotDefinition,
	#instVars : [
		'moduleName',
		'collectionSlotName'
	],
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #accessing }
LcsGlobalCollectonReferenceSlotDefinition >> collectionSlotName [
	^ collectionSlotName
]

{ #category : #accessing }
LcsGlobalCollectonReferenceSlotDefinition >> collectionSlotName: anObject [
	collectionSlotName := anObject
]

{ #category : #accessing }
LcsGlobalCollectonReferenceSlotDefinition >> globalCollectionSlotDefinition [
	^ self module slotDefinitionNamed: self collectionSlotName
]

{ #category : #accessing }
LcsGlobalCollectonReferenceSlotDefinition >> initializeModel: aDomainObject [
	"The global collection is initialized by the module, not from the parent"
]

{ #category : #accessing }
LcsGlobalCollectonReferenceSlotDefinition >> module [
	^ self currentSystem moduleNamed: self moduleName
]

{ #category : #accessing }
LcsGlobalCollectonReferenceSlotDefinition >> moduleName [
	^ moduleName
]

{ #category : #accessing }
LcsGlobalCollectonReferenceSlotDefinition >> moduleName: aString [ 
	moduleName := aString
]

{ #category : #accessing }
LcsGlobalCollectonReferenceSlotDefinition >> persistValue: aDomainObject [
	(self module slotDefinitionNamed: self collectionSlotName) persistValue: aDomainObject in: self module

]
