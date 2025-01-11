Class {
	#name : #LcsCompositeSlot,
	#superclass : #LcsSlotDefinition,
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #'slot model' }
LcsCompositeSlot >> setValueTo: anObject in: aDomainObject [
	| originalObject |
	originalObject := self getPersistedValueIn: aDomainObject.
	self _setValueTo: anObject in: aDomainObject.
	(originalObject isKindOf: #LcsDomainObject asClass)
		ifTrue: [ self currentUnitOfWork deleteObject: originalObject ]
]
