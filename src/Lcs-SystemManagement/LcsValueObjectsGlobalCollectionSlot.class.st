Class {
	#name : #LcsValueObjectsGlobalCollectionSlot,
	#superclass : #LcsPrimaryCollectionSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #'object initialization' }
LcsValueObjectsGlobalCollectionSlot >> initializeSlotValueIn: aDomainObject [
	super initializeSlotValueIn: aDomainObject.
	self populateCollection 
]

{ #category : #properties }
LcsValueObjectsGlobalCollectionSlot >> loaderClass [
	^ self propertyAt: 'loaderClass' ifAbsent: [ ]
]

{ #category : #properties }
LcsValueObjectsGlobalCollectionSlot >> loaderClass: aLoaderClass [
	self propertyAt: 'loaderClass' put: aLoaderClass
]

{ #category : #load }
LcsValueObjectsGlobalCollectionSlot >> populateCollection [
	self loaderClass new load
]
