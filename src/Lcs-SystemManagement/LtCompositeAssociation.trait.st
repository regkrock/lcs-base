Trait {
	#name : #LtCompositeAssociation,
	#category : #'Lcs-SystemManagement-Traits'
}

{ #category : #'slot model' }
LtCompositeAssociation >> slotVarPut: anObject in: aDomainObject [
	| originalObject |
	"More work required here as the fact that they were swapped needs to be recorded"
	"The removed object is not deleted since it's life cycle is independent of the parent"
	originalObject := self persistedSlotVarIn: aDomainObject.
	super slotVarPut: anObject in: aDomainObject.
	(originalObject isDomainObject)
		ifTrue: [ self currentUnitOfWork deleteObject: originalObject ]
]
