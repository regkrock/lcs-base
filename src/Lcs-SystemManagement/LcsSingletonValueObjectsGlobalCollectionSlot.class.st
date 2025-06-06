Class {
	#name : #LcsSingletonValueObjectsGlobalCollectionSlot,
	#superclass : #LcsGlobalCollectionSlot,
	#instVars : [
		'codeSuperclass'
	],
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #accessing }
LcsSingletonValueObjectsGlobalCollectionSlot >> codeSuperclass [
	^ codeSuperclass
]

{ #category : #accessing }
LcsSingletonValueObjectsGlobalCollectionSlot >> codeSuperclass: aCodeClass [
	codeSuperclass := aCodeClass
]

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
	self codeSuperclass allSubclassesDo: [ :each | each new ]
]
