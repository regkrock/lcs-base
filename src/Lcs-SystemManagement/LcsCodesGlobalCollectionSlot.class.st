Class {
	#name : #LcsCodesGlobalCollectionSlot,
	#superclass : #LcsGlobalCollectionSlot,
	#instVars : [
		'loaderClass'
	],
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #'object initialization' }
LcsCodesGlobalCollectionSlot >> initializeSlotValueIn: aDomainObject [
	super initializeSlotValueIn: aDomainObject.
	self populateCollection 
]

{ #category : #accessing }
LcsCodesGlobalCollectionSlot >> loaderClass [
	^ loaderClass
]

{ #category : #accessing }
LcsCodesGlobalCollectionSlot >> loaderClass: aLoaderClass [
	loaderClass := aLoaderClass
]

{ #category : #'as yet unclassified' }
LcsCodesGlobalCollectionSlot >> populateCollection [
	self loaderClass new load
]
