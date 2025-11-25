Class {
	#name : 'LcsDomainObjectWithoutTestSystemTest',
	#superclass : 'LcsTestWithNoTestSystemSetupForTest',
	#category : 'Lcs-PrototypeSystemTests-Tests',
	#package : 'Lcs-PrototypeSystemTests',
	#tag : 'Tests'
}

{ #category : 'tests' }
LcsDomainObjectWithoutTestSystemTest >> testCreationWithNilCurrentSystem [
	self assert: LcsApplicationEnvironment currentSystem isNil.
	self should: [ LcsDomainObject new ] raise: LcsSlotModelNotInitializedError.
	self should: [ LxxPrototypeSystem verifySlotModelInitialized ] raise: LcsSlotModelNotInitializedError
]
