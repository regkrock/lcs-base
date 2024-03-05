Class {
	#name : #LcsGlobalCollectionSlotDefinition,
	#superclass : #LcsSlotDefinition,
	#category : #'Lcs-Geography'
}

{ #category : #accessing }
LcsGlobalCollectionSlotDefinition >> persistValue: anObject [
	(self getValueIn: self slotName asString) persistValue: anObject
]

{ #category : #accessing }
LcsGlobalCollectionSlotDefinition >> persistValue: anObject in: aModule [
	(self getValueIn: aModule) add: anObject
]
