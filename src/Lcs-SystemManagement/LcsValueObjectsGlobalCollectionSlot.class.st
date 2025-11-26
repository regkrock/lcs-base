Class {
	#name : 'LcsValueObjectsGlobalCollectionSlot',
	#superclass : 'LcsPrimaryCollectionSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'object initialization' }
LcsValueObjectsGlobalCollectionSlot >> initializeSlotValueIn: aDomainObject [
	super initializeSlotValueIn: aDomainObject.
	self populateCollection: (aDomainObject perform: self slotName asSymbol) 
]

{ #category : 'properties' }
LcsValueObjectsGlobalCollectionSlot >> loaderClass [
	^ self propertyAt: 'loaderClass' ifAbsent: [ ]
]

{ #category : 'properties' }
LcsValueObjectsGlobalCollectionSlot >> loaderClass: aLoaderClass [
	self propertyAt: 'loaderClass' put: aLoaderClass
]

{ #category : 'load' }
LcsValueObjectsGlobalCollectionSlot >> populateCollection: aTargetCollection [
	self loaderClass new loadInto: aTargetCollection
]
