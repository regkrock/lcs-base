Trait {
	#name : #LtDirectSlotAccess,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #'slot model' }
LtDirectSlotAccess >> slotVarPut: anObject in: aDomainObject [
	self verifyType: anObject.
	aDomainObject instVarNamed: self slotName put: anObject
]
