Class {
	#name : #LcsDomainObjectTest,
	#superclass : #LcsWithPrototypeSystemSetUpForTest,
	#category : #'Lcs-PrototypeSystemTests-Tests'
}

{ #category : #tests }
LcsDomainObjectTest >> testCreatingNewDomainObject [
	| domainObject |
	
	self assert: self currentUnitOfWork hasNoChanges.

	domainObject := LcsDomainObject new.

	self assert: self currentUnitOfWork addedObjects size equals: 1.
	self assert: self currentUnitOfWork deletedObjects isEmpty.
	self assert: self currentUnitOfWork changedObjects isEmpty.
	self assert: (self currentUnitOfWork addedObjects any isKindOf: LcsAddedObjectRecord).
	self assert: (self currentUnitOfWork addedObjects keys includes:  domainObject)
]

{ #category : #tests }
LcsDomainObjectTest >> testHistoryCreationWithNewDomainObject [
	| domainObject |
		
	domainObject := LcsDomainObject new.

	"Set parent to a 'nonsensical' value so changes can be applied. This is a hack for this test"
	domainObject instVarNamed: 'parent' put: self currentSystem.
	
	self currentSystem applyChanges.
	self assert: domainObject creationDate equals: domainObject history creationTimestamp asDate.
	self assert: domainObject creationDate equals: Date today.
	self assert: domainObject creationTimestamp equals: domainObject history creationTimestamp.
	self assert: domainObject lastUpdatedDate equals: domainObject history creationTimestamp asDate.
	self assert: domainObject lastUpdatedTimestamp equals: domainObject history creationTimestamp.
	self assert: domainObject creator equals: self currentSystem currentUser.
	self assert: domainObject history userUuid isInteger
]
