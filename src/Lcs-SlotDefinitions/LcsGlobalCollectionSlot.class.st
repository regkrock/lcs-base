"
This is used to define a global collection slot. All of the items stored in this collection are rooted in this collection.
"
Class {
	#name : #LcsGlobalCollectionSlot,
	#superclass : #LcsPrimaryCollectionSlot,
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #'as yet unclassified' }
LcsGlobalCollectionSlot >> add: aDomainObject [
	self slotTypes do: [ :eachTypeClass | (aDomainObject inheritsFrom: eachTypeClass) ifTrue: [ ^ true ] ]
]

{ #category : #accessing }
LcsGlobalCollectionSlot >> isGlobalCollectionSlot [
	^ true
]

{ #category : #'slot model' }
LcsGlobalCollectionSlot >> persistValue: anObject contextObject: aContextDomainObject [
	(self getValueIn: self slotName asString) persistValue: anObject contextObject: aContextDomainObject
]

{ #category : #'slot model' }
LcsGlobalCollectionSlot >> persistValue: anObject in: aModule [
	(self getValueIn: aModule) add: anObject
]

{ #category : #'as yet unclassified' }
LcsGlobalCollectionSlot >> verifyCollectionItemType: anObject [
	self slotTypes
		detect: [ :eachClass | anObject isKindOf: eachClass ]
		ifNone: [ 
			self currentUnitOfWork removeAddOf: anObject.
			LcsInvalidSlotType newInvalidParentTypeObject: anObject forSlot: self ]
]
