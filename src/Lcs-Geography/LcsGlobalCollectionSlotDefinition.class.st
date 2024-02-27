Class {
	#name : #LcsGlobalCollectionSlotDefinition,
	#superclass : #LcsSlotDefinition,
	#instVars : [
		'collectionClass'
	],
	#category : #'Lcs-Geography'
}

{ #category : #accessing }
LcsGlobalCollectionSlotDefinition >> collectionClass: anObject [ 
	collectionClass := anObject
]
