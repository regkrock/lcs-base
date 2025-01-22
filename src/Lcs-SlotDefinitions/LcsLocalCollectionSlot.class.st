Class {
	#name : #LcsLocalCollectionSlot,
	#superclass : #LcsPrimaryCollectionSlot,
	#instVars : [
		'collectionSlotClass'
	],
	#category : #'Lcs-SlotDefinitions-Core'
}

{ #category : #accessing }
LcsLocalCollectionSlot >> isLocalCollectionSlot [
	^ true
]

{ #category : #'slot model' }
LcsLocalCollectionSlot >> persistValue: anObject contextObject: aContextDomainObject [
	(self getValueIn: self slotName asString) persistValue: anObject contextObject: aContextDomainObject
]

{ #category : #'slot model' }
LcsLocalCollectionSlot >> persistValue: anObject in: aModule [
	(self getValueIn: aModule) add: anObject
]
