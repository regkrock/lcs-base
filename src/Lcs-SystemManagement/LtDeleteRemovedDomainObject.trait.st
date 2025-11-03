Trait {
	#name : #LtDeleteRemovedDomainObject,
	#category : #'Lcs-SystemManagement-Traits'
}

{ #category : #'slot model' }
LtDeleteRemovedDomainObject >> slotVarPut: anObject in: aDomainObject [
	| existingValue |
	existingValue := self persistedSlotVarIn: aDomainObject.
	self slotVarPut: anObject in: aDomainObject oldValue: existingValue.
	(existingValue isDomainObject)
		ifTrue: [ self currentUnitOfWork deleteObject: existingValue ]
]
