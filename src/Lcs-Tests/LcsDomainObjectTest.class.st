Class {
	#name : #LcsDomainObjectTest,
	#superclass : #LcsTestCase,
	#category : #'Lcs-Tests'
}

{ #category : #tests }
LcsDomainObjectTest >> testCreationWithNilCurrentSystem [
	| domainObject |
	domainObject := LcsDomainObject new.
	self assert: domainObject parent isNil.
	self assert: domainObject currentSystem isNil.
	self assert: (domainObject slotDefintions isKindOf: LcsSlotDefinitions).
	self should: [ domainObject slotDefinitionNamed: 'slotDoesNotExist' ] raise: LcsSlotDoesNotExistError.
	self should: [ domainObject setValueOfSlotNamed: 'slotDoesNotExist' to: 1 ] raise: LcsSlotDoesNotExistError.
	self should: [ domainObject getValueOfSlotNamed: 'slotDoesNotExist' ] raise: LcsSlotDoesNotExistError.
]
