Class {
	#name : #LcsApplicationObjectTest,
	#superclass : #LcsTestWithNoTestSystemSetupForTest,
	#category : #'Lcs-SystemManagementTests'
}

{ #category : #test }
LcsApplicationObjectTest >> testCurrentSystemDoesNotExist [
	self assert: LcsApplicationObject currentSystem isNil.
	self assert: LcsApplicationObject new currentSystem isNil
]

{ #category : #test }
LcsApplicationObjectTest >> testCurrentUnitOfWorkDoesNotExist [
	self assert: LcsApplicationObject currentUnitOfWork isNil.
	self assert: LcsApplicationObject new currentUnitOfWork isNil
]

{ #category : #'as yet unclassified' }
LcsApplicationObjectTest >> testLcsObjectHasNoninitializedSlotModel [
	self assert: LcsDomainObject hasNoninitializedSlotModel equals: true
]
