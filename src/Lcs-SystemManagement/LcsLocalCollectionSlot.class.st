Class {
	#name : #LcsLocalCollectionSlot,
	#superclass : #LcsPrimaryCollectionSlot,
	#instVars : [
		'collectionSlotClass'
	],
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #accessing }
LcsLocalCollectionSlot >> isLocalCollectionSlot [
	^ true
]

{ #category : #'slot model' }
LcsLocalCollectionSlot >> persistValue: anObject contextObject: aContextDomainObject [
	(self currentSlotVarIn: self slotName asString) persistValue: anObject contextObject: aContextDomainObject
]

{ #category : #'slot model' }
LcsLocalCollectionSlot >> persistValue: anObject in: aModule [
	(self currentSlotVarIn: aModule) add: anObject
]
