Class {
	#name : #LcsLocalCollectionSlot,
	#superclass : #LcsPrimaryCollectionSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #testing }
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
