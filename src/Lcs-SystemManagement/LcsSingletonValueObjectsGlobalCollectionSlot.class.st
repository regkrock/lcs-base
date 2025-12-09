Class {
	#name : 'LcsSingletonValueObjectsGlobalCollectionSlot',
	#superclass : 'LcsDomainCollectionSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'initialize' }
LcsSingletonValueObjectsGlobalCollectionSlot >> initialize [ 
	super initialize.
	self priority: 10
]

{ #category : 'object initialization' }
LcsSingletonValueObjectsGlobalCollectionSlot >> initializeSlotValueIn: aDomainObject [
	super initializeSlotValueIn: aDomainObject.
	self populateCollection
]

{ #category : 'testing' }
LcsSingletonValueObjectsGlobalCollectionSlot >> isGlobalCollectionSlot [
	^ true
]

{ #category : 'load' }
LcsSingletonValueObjectsGlobalCollectionSlot >> populateCollection [
	self valueObjectSuperclass allSubclassesDo: [ :each | each new ]
]

{ #category : 'properties' }
LcsSingletonValueObjectsGlobalCollectionSlot >> valueObjectSuperclass [
	^ self propertyAt: 'valueObjectSuperclass' ifAbsent: [ ]
]

{ #category : 'properties' }
LcsSingletonValueObjectsGlobalCollectionSlot >> valueObjectSuperclass: aCodeClass [
	self propertyAt: 'valueObjectSuperclass' put: aCodeClass
]
