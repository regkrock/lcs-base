Class {
	#name : #LcsAggregateSlot,
	#superclass : #LcsSlotDefinition,
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #'slot model' }
LcsAggregateSlot >> setValueTo: anObject in: aDomainObject [
	| originalObject |
	self error: 'The logic below is for composite, it must be changed'.
	originalObject := self getPersistedValueIn: aDomainObject.
	self _setValueTo: anObject in: aDomainObject.
	self currentUnitOfWork deleteObject: originalObject
]
