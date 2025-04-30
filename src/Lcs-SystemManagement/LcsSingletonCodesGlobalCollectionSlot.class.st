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

{ #category : #'as yet unclassified' }
LcsSingletonCodesGlobalCollectionSlot >> initializeSlotValueIn: aDomainObject [
	super initializeSlotValueIn: aDomainObject.
	self codeSuperclass allSubclassesDo: [ :each | each new ]
]
