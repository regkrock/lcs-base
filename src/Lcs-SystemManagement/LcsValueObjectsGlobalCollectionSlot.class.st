Class {
	#name : #LcsValueObjectsGlobalCollectionSlot,
	#superclass : #LcsGlobalCollectionSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #'object initialization' }
LcsValueObjectsGlobalCollectionSlot >> initializeSlotValueIn: aDomainObject [
	super initializeSlotValueIn: aDomainObject.
	self populateCollection 
]

{ #category : #properties }
LcsValueObjectsGlobalCollectionSlot >> loaderClass [
	^ self properties at: 'loaderClass' ifAbsent: [ ]
]

{ #category : #properties }
LcsValueObjectsGlobalCollectionSlot >> loaderClass: aLoaderClass [
	self properties at: 'loaderClass' put: aLoaderClass
]

{ #category : #load }
LcsValueObjectsGlobalCollectionSlot >> populateCollection [
	self loaderClass new load
]
