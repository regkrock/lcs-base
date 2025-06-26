Class {
	#name : #LcsSingletonValueObjectsGlobalCollectionSlot,
	#superclass : #LcsGlobalCollectionSlot,
	#instVars : [
		'valueObjectSuperclass'
	],
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #'as yet unclassified' }
LcsSingletonValueObjectsGlobalCollectionSlot >> initialize [ 
	super initialize.
	self priority: 10
]

{ #category : #'object initialization' }
LcsSingletonValueObjectsGlobalCollectionSlot >> initializeSlotValueIn: aDomainObject [
	super initializeSlotValueIn: aDomainObject.
	self populateCollection
]

{ #category : #'as yet unclassified' }
LcsSingletonValueObjectsGlobalCollectionSlot >> populateCollection [
	self valueObjectSuperclass allSubclassesDo: [ :each | each new ]
]

{ #category : #accessing }
LcsSingletonValueObjectsGlobalCollectionSlot >> valueObjectSuperclass [
	^ valueObjectSuperclass
]

{ #category : #accessing }
LcsSingletonValueObjectsGlobalCollectionSlot >> valueObjectSuperclass: aCodeClass [
	valueObjectSuperclass := aCodeClass
]
