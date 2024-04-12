Class {
	#name : #LcsDomainObjectTest,
	#superclass : #LcsDomainTestCase,
	#category : #'Lcs-Tests'
}

{ #category : #tests }
LcsDomainObjectTest >> testCreationWithNilCurrentSystem [
	| domainObject |
	domainObject := LcsDomainObject new.
	self assert: domainObject parent isNil.
	self assert: domainObject currentSystem isNil.
	self assert: (domainObject slotModel isNil).
	self should: [ domainObject slotDefinitionNamed: 'slotDoesNotExist' ] raise: LcsSlotModelNotInitializedError.
	self should: [ domainObject setValueOfSlotNamed: 'slotDoesNotExist' to: 1 ] raise: LcsSlotModelNotInitializedError.
	self should: [ domainObject getValueOfSlotNamed: 'slotDoesNotExist' ] raise: LcsSlotModelNotInitializedError.
]
