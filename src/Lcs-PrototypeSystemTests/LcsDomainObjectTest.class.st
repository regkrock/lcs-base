Class {
	#name : #LcsDomainObjectTest,
	#superclass : #LcsTestWithNoTestSystemSetupForTest,
	#category : #'Lcs-PrototypeSystemTests-Tests'
}

{ #category : #tests }
LcsDomainObjectTest >> testCreationWithNilCurrentSystem [
	self assert: LcsApplicationEnvironment currentSystem isNil.
	self should: [ LcsDomainObject new ] raise: LcsSlotModelNotInitializedError.
	self should: [ LxxPrototypeSystem verifySlotModelInitialized ] raise: LcsSlotModelNotInitializedError
]
