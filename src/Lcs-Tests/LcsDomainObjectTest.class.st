Class {
	#name : #LcsDomainObjectTest,
	#superclass : #LcsDomainTest,
	#category : #'Lcs-Tests-Tests'
}

{ #category : #tests }
LcsDomainObjectTest >> testCreationWithNilCurrentSystem [

	self should: [ self domainObjectClass new ] raise: LcsSlotModelNotInitializedError
]
