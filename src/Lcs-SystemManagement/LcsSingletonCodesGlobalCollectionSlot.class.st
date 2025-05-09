Class {
	#name : #LcsSingletonCodesGlobalCollectionSlot,
	#superclass : #LcsGlobalCollectionSlot,
	#instVars : [
		'codeSuperclass'
	],
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #accessing }
LcsSingletonCodesGlobalCollectionSlot >> codeSuperclass [
	^ codeSuperclass
]

{ #category : #accessing }
LcsSingletonCodesGlobalCollectionSlot >> codeSuperclass: aCodeClass [
	codeSuperclass := aCodeClass
]

{ #category : #'object initialization' }
LcsSingletonCodesGlobalCollectionSlot >> initializeSlotValueIn: aDomainObject [
	super initializeSlotValueIn: aDomainObject.
	self populateCollection 
]

{ #category : #'as yet unclassified' }
LcsSingletonCodesGlobalCollectionSlot >> populateCollection [
	self codeSuperclass allSubclassesDo: [ :each | each new ]
]
