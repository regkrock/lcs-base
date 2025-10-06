Class {
	#name : #LcsSingletonValueObjectsGlobalCollectionSlot,
	#superclass : #LcsPrimaryCollectionSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #initialize }
LcsSingletonValueObjectsGlobalCollectionSlot >> initialize [ 
	super initialize.
	self priority: 10
]

{ #category : #'object initialization' }
LcsSingletonValueObjectsGlobalCollectionSlot >> initializeSlotValueIn: aDomainObject [
	super initializeSlotValueIn: aDomainObject.
	self populateCollection
]

{ #category : #load }
LcsSingletonValueObjectsGlobalCollectionSlot >> populateCollection [
	self valueObjectSuperclass allSubclassesDo: [ :each | each new ]
]

{ #category : #properties }
LcsSingletonValueObjectsGlobalCollectionSlot >> valueObjectSuperclass [
	^ self propertyAt: 'valueObjectSuperclass' ifAbsent: [ ]
]

{ #category : #properties }
LcsSingletonValueObjectsGlobalCollectionSlot >> valueObjectSuperclass: aCodeClass [
	self propertyAt: 'valueObjectSuperclass' put: aCodeClass
]
