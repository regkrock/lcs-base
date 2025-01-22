Class {
	#name : #LcsObjectTest,
	#superclass : #LcsTestWithNoTestSystemSetupForTest,
	#category : #'Lcs-Tests'
}

{ #category : #'as yet unclassified' }
LcsObjectTest >> testCreatingSelectorName [
	self assert: (LcsObject new selectorNameFrom: 'IsSelector') equals: #isSelector.
	self assert: (LcsObject new selectorNameFrom: 'Is Selector') equals: #isSelector 
]

{ #category : #test }
LcsObjectTest >> testCurrentSystemDoesNotExist [
	self assert: LcsObject currentSystem isNil.
	self assert: LcsObject new currentSystem isNil
]

{ #category : #test }
LcsObjectTest >> testCurrentUnitOfWorkDoesNotExist [
	self assert: LcsObject currentUnitOfWork isNil.
	self assert: LcsObject new currentUnitOfWork isNil
]

{ #category : #test }
LcsObjectTest >> testLcsObjectHasNoninitializedSlotModel [
	self assert: LcsDomainObject hasNoninitializedSlotModel equals: true
]

{ #category : #test }
LcsObjectTest >> testLcsObjectIsNotAnApplicationSystem [
	self assert: LcsObject new isApplicationSystem equals: false
]

{ #category : #test }
LcsObjectTest >> testLcsObjectNotADomainClass [
	self assert: LcsObject isDomainClass equals: false
]
