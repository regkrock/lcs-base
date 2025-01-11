Class {
	#name : #LcsDomainObjectTest,
	#superclass : #LcsTestCase,
	#category : #'Lcs-Tests-Tests'
}

{ #category : #tests }
LcsDomainObjectTest >> testCreationWithNilCurrentSystem [

	self assert: LcsApplicationEnvironment currentSystem isNil.
	self should: [ self domainObjectClass new ] raise: LcsSlotModelNotInitializedError
]
