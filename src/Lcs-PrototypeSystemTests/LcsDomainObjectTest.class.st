Class {
	#name : #LcsDomainObjectTest,
	#superclass : #LcsNoExistingSetupSystemTest,
	#category : #'Lcs-PrototypeSystemTests-Tests'
}

{ #category : #tests }
LcsDomainObjectTest >> testCreationWithNilCurrentSystem [
	self assert: LcsApplicationEnvironment currentSystem isNil.
	self should: [ self domainObjectClass new ] raise: LcsSlotModelNotInitializedError.
	self should: [ LxxPrototypeSystem verifySlotModelInitialized ] raise: LcsSlotModelNotInitializedError
]
