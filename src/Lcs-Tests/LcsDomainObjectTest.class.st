Class {
	#name : #LcsDomainObjectTest,
	#superclass : #LcsDomainTestCase,
	#category : #'Lcs-Tests'
}

{ #category : #tests }
LcsDomainObjectTest >> testCreationWithNilCurrentSystem [
	| domainObject |
	LcsApplicationEnvironment releaseEnvironment.
	domainObject := LcsDomainObject new.
	self assert: domainObject parent isNil.
	self assert: domainObject currentSystem isNil.
	self assert: (domainObject slotDefinitions isNil).
	self should: [ domainObject slotDefinitionNamed: 'slotDoesNotExist' ] raise: LcsSlotDefinitionsNotInitializedError.
	self should: [ domainObject setValueOfSlotNamed: 'slotDoesNotExist' to: 1 ] raise: LcsSlotDefinitionsNotInitializedError.
	self should: [ domainObject getValueOfSlotNamed: 'slotDoesNotExist' ] raise: LcsSlotDefinitionsNotInitializedError.
]
