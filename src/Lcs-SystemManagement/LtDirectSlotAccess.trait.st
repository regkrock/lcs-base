Trait {
	#name : #LtDirectSlotAccess,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #'slot model' }
LtDirectSlotAccess >> slotVarPut: anObject in: aDomainObject [
	self verifyType: anObject for: aDomainObject.
	aDomainObject instVarNamed: self slotName put: anObject
]
