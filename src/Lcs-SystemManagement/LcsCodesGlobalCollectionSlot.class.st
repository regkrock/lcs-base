Class {
	#name : #LcsCodesGlobalCollectionSlot,
	#superclass : #LcsGlobalCollectionSlot,
	#instVars : [
		'codeSuperclass'
	],
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #accessing }
LcsCodesGlobalCollectionSlot >> codeSuperclass [
	^ codeSuperclass
]

{ #category : #accessing }
LcsCodesGlobalCollectionSlot >> codeSuperclass: aCodeClass [ 
	codeSuperclass := aCodeClass
]

{ #category : #'as yet unclassified' }
LcsCodesGlobalCollectionSlot >> initializeSlotValueIn: aDomainObject [
	super initializeSlotValueIn: aDomainObject.
	self codeSuperclass allSubclassesDo: [ :each | each new ]
]
