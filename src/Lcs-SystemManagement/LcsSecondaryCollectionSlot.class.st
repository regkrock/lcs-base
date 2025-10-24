Class {
	#name : #LcsSecondaryCollectionSlot,
	#superclass : #LcsDomainCollectionSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #initialize }
LcsSecondaryCollectionSlot >> initialize [
	super initialize.
	self beIdentitySetCollection
]

{ #category : #'slot model' }
LcsSecondaryCollectionSlot >> persistValue: anObject contextObject: aContextDomainObject [
	(self _currentSlotVarIn: self slotName asString) persistValue: anObject  contextObject: aContextDomainObject
]

{ #category : #'slot model' }
LcsSecondaryCollectionSlot >> persistValue: anObject in: aModule [
	(self _currentSlotVarIn: aModule) add: anObject
]
