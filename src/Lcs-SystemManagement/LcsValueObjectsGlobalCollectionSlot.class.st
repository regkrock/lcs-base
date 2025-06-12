Class {
	#name : #LcsValueObjectsGlobalCollectionSlot,
	#superclass : #LcsGlobalCollectionSlot,
	#instVars : [
		'loaderClass'
	],
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #'object initialization' }
LcsValueObjectsGlobalCollectionSlot >> initializeSlotValueIn: aDomainObject [
	super initializeSlotValueIn: aDomainObject.
	self populateCollection 
]

{ #category : #accessing }
LcsValueObjectsGlobalCollectionSlot >> loaderClass [
	^ loaderClass
]

{ #category : #accessing }
LcsValueObjectsGlobalCollectionSlot >> loaderClass: aLoaderClass [
	loaderClass := aLoaderClass
]

{ #category : #'as yet unclassified' }
LcsValueObjectsGlobalCollectionSlot >> populateCollection [
	self loaderClass new load
]
