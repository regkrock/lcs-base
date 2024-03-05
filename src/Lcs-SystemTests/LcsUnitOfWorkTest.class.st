Class {
	#name : #LcsUnitOfWorkTest,
	#superclass : #LcsTestCase,
	#category : #'Lcs-SystemTests'
}

{ #category : #accessing }
LcsUnitOfWorkTest >> testAddDomainObject [
	| domainObject |
	self assert: LcsSystem currentUnitOfWork addedObjects isEmpty.
	self assert: LcsSystem currentUnitOfWork deletedObjects isEmpty.
	self assert: LcsSystem currentUnitOfWork changedObjects isEmpty.
	domainObject := LcsDomainObject new.
	self assert: LcsSystem currentUnitOfWork addedObjects size = 1.
	self assert: LcsSystem currentUnitOfWork deletedObjects isEmpty.
	self assert: LcsSystem currentUnitOfWork changedObjects isEmpty.
	self assert: (LcsSystem currentUnitOfWork addedObjects any isKindOf: LcsAddedObjectRecord).
	self assert: LcsSystem currentUnitOfWork addedObjects any domainObject == domainObject
	
]

{ #category : #accessing }
LcsUnitOfWorkTest >> testChangedSlotInDomainObject [
	| domainObject |

	domainObject := LcsPerson new dateOfBirth: Date today.
	self currentSystem currentUnitOfWork applyChanges.
	self assert: domainObject dateOfBirth = Date today.
	self assert: ((self currentSystem  legalEntitiesModule persons) includes: domainObject).
	self assert: self currentSystem currentUnitOfWork addedObjects isEmpty.
	self assert: self currentSystem currentUnitOfWork deletedObjects isEmpty.
	self assert: self currentSystem currentUnitOfWork changedObjects isEmpty.

	domainObject dateOfBirth: Date yesterday.
	self assert: self currentSystem currentUnitOfWork addedObjects isEmpty.
	self assert: self currentSystem currentUnitOfWork deletedObjects isEmpty.
	self assert: self currentSystem currentUnitOfWork changedObjects size = 1.
	self assert: (self currentSystem currentUnitOfWork changedObjects any isKindOf: LcsChangedObjectRecord).
	self assert: self currentSystem currentUnitOfWork changedObjects any domainObject == domainObject.
	self currentSystem currentUnitOfWork applyChanges.

	self assert: domainObject dateOfBirth = Date yesterday.
	self assert: self currentSystem currentUnitOfWork addedObjects isEmpty.
	self assert: self currentSystem currentUnitOfWork deletedObjects isEmpty.
	self assert: self currentSystem currentUnitOfWork changedObjects isEmpty.

]

{ #category : #test }
LcsUnitOfWorkTest >> testCreation [

	| unitOfWork |

	unitOfWork := LcsUnitOfWork new.
	self assert: unitOfWork system isNil.
	self assert: unitOfWork addedObjects isEmpty.
	self assert: unitOfWork deletedObjects isEmpty.
	self assert: unitOfWork changedObjects isEmpty.
]

{ #category : #accessing }
LcsUnitOfWorkTest >> testDeleteDomainObject [
	| domainObject |
	domainObject := LcsDomainObject new.
	LcsSystem newSystem.
	self assert: self currentSystem currentUnitOfWork addedObjects isEmpty.
	self assert: self currentSystem currentUnitOfWork deletedObjects isEmpty.
	self assert: self currentSystem currentUnitOfWork changedObjects isEmpty.
	domainObject delete.
	self assert: self currentSystem currentUnitOfWork addedObjects isEmpty.
	self assert: self currentSystem currentUnitOfWork deletedObjects size = 1.
	self assert: self currentSystem currentUnitOfWork changedObjects isEmpty.
	self assert: (self currentSystem currentUnitOfWork deletedObjects any isKindOf: LcsDeletedObjectRecord).
	self assert: self currentSystem currentUnitOfWork deletedObjects any domainObject == domainObject
]

{ #category : #test }
LcsUnitOfWorkTest >> testNewUnitOfWorkInSystem [
	self assert: (self currentSystem currentUnitOfWork system == self  currentSystem)
]
