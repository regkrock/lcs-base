Trait {
	#name : #LtAggregateAssociation,
	#category : #'Lcs-SystemManagement-Traits'
}

{ #category : #'slot model' }
LtAggregateAssociation >> slotVarPut: anObject in: aDomainObject [
	| originalObject |
	"More work required here as the fact that they were sapped needs to be recorded"
	originalObject := self persistedSlotVarIn: aDomainObject.
	super slotVarPut: anObject in: aDomainObject.
	"self currentUnitOfWork deleteObject: originalObject"
]
